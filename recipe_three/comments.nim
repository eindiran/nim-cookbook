# Nim Cookbook
# Recipe 3 -- Fun with Comments

import parseutils ## Use parseutils to parse a string to an int

# Documentation comments start with '##'
var num_pizzas: int ## num_pizzas is the number of pizzas to order

#[
    Multiline comments use the hash-bracket syntax seen here.
    There are no requirements indentation/whitespace.
    Additionally you can use the `discard` statement to
    throw away a return value, allowing you to spoof comments.
]# 

discard """Anything can occur inside the long-string literal
           here. No indent restrictions. Arbitrary Nim code
           can be used as well. """

echo "How many pizzas do you want?\t\t"
let tmp: string = readLine(stdin)
discard parseInt(tmp, num_pizzas)
echo "You wanted ", num_pizzas, " pizzas."
