# Swift Parser Sample

This is an interpreter and parser for a basic math "language" based on [Crafting Interpreters](https://www.craftinginterpreters.com), written in the Swift programming language.

This is purposely made simple to show how to make a slightly more advanced calculator in a simple way.

It has two parts, an AST generator and the regular program which interprets your input line by line.

The AST generator will parse the `grammar.txt` and `statementgrammar.txt` files in the XCode project to generate the classes to present to the user.

The interpreter can interpret a few expressions, such as:

```
print VALUE;
```

```
x = 1 + 2;
```

```
y = 1;
x = (y + 1) * (y + 1);
```

Each statement must end with a `;`

# License

This is licensed with the [MIT](https://opensource.org/licenses/MIT) license.
