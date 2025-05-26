#!/usr/bin/env python3
import json
import argparse

def json_to_text(json_file, text_file):
    """Convert the JSON config file to text format."""
    try:
        with open(json_file, 'r') as f:
            configs = json.load(f)
        
        with open(text_file, 'w') as f:
            for name, config in configs.items():
                enabled = '1'  # Default to enabled
                src_path = config.get('src_path', '')
                dst_path = config.get('dst_path', '')
                is_directory = str(config.get('is_directory', False)).lower()
                is_symlink = str(config.get('is_symlink', False)).lower()
                
                line = f"{enabled}|{name}|{src_path}|{dst_path}|{is_directory}|{is_symlink}\n"
                f.write(line)
        
        print(f"Successfully converted {json_file} to {text_file}")
        return True
    except Exception as e:
        print(f"Error converting JSON to text: {str(e)}")
        return False

def text_to_json(text_file, json_file):
    """Convert the text config file to JSON format."""
    try:
        configs = {}
        with open(text_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                
                parts = line.split('|')
                if len(parts) != 6:
                    print(f"Invalid format in line: {line}")
                    continue
                
                enabled, name, src_path, dst_path, is_directory, is_symlink = parts
                
                if enabled != '1':  # Skip disabled entries
                    continue
                
                configs[name] = {
                    "src_path": src_path,
                    "dst_path": dst_path,
                    "is_directory": is_directory.lower() == 'true',
                    "is_symlink": is_symlink.lower() == 'true'
                }
        
        with open(json_file, 'w') as f:
            json.dump(configs, f, indent=2)
        
        print(f"Successfully converted {text_file} to {json_file}")
        return True
    except Exception as e:
        print(f"Error converting text to JSON: {str(e)}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Convert between JSON and text config formats')
    parser.add_argument('--to-text', action='store_true', help='Convert from JSON to text format')
    parser.add_argument('--to-json', action='store_true', help='Convert from text to JSON format')
    parser.add_argument('--input', required=True, help='Input file path')
    parser.add_argument('--output', required=True, help='Output file path')
    
    args = parser.parse_args()
    
    if args.to_text and args.to_json:
        print("Error: Cannot specify both --to-text and --to-json")
        return False
    
    if args.to_text:
        return json_to_text(args.input, args.output)
    elif args.to_json:
        return text_to_json(args.input, args.output)
    else:
        print("Error: Must specify either --to-text or --to-json")
        return False

if __name__ == "__main__":
    main()