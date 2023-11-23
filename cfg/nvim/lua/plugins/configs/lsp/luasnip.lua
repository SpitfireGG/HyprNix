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
})
ls.add_snippets("c", {
	s("func", {
		t("int main(void)  return 0; } "),
	}),
	s("pands", {
		t('printf("\n"); scanf("");'),
	}),
})
