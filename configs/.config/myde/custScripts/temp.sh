
#!/bin/bash

check() {
  for i in "${req[@]}"
  do
    if [[ "$check_val" ]]; then
      echo "$check_val"
      return 
    else
      return 0
    fi
  done
}

req=("item1" "item2" "item3")  # Example array of elements for 'req'
check_val="some_value"  # Example value for 'check_val'

result=$(check)
echo "Result: $result"
