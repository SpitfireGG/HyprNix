local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("lua", {
    s("hello", {
        t('print("hello world")'),
    }),
})
ls.add_snippets("html", {
    s("fuck", {
        t(
            '(<!DOCTYPE html> <html> <head>    <meta charset="UTF-8" />  <meta http-equiv="X-UA-Compatible" content="IE=edge" />    <meta name="viewport" content="width=device-width, initial-scale=1.0" />    <link rel="stylesheet" type="text/css" href="style.css" />    <title>Link CSS to HTML</title></head><p id="paragraph">decore</p><body>    <script type="text/javascript" src="./script.js">    </script></body></html>)'
        ),
    }),
    s("snaps", {
        t(
            "Programs in awk are different from programs in most other languages. Most languages are data-driven, meaning that you must describe the data you want to work with and then what you want to do with it. Most languages are procedural (or at least support procedural syntax), meaning you have to describe, in detail, every successive step a given program should take. When working with procedural languages, it is usually much harder to clearly describe the data your program will process. For this reason, awk programs are often refreshingly easy to read and write in these scenarios."
        ),
    }),
})
ls.add_snippets("c", {
    s("func", {
        t("int main(void)  return 0; } "),
    }),
    s("pands", {
        t('printf("\n"); scanf("");'),
    }),
})

ls.add_snippets("go", {
    s("main", {
        t("func main() { } "),
    }),
    s("print", {
        t("fmt.Println()"),
    }),
})
ls.add_snippets("javascript", {
    s("log", {
        t("console.log"),
    }),
})
