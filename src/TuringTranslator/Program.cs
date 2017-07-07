﻿using System;
using System.IO;
using System.Text;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;

namespace TuringTranslator
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			if(args.Length != 2) {
				Console.WriteLine("usage: TuringTranslator.exe [input file] [output file]");
				Environment.Exit(1);
			}

			string input = File.ReadAllText(args[0]);

			var ms = new MemoryStream(Encoding.UTF8.GetBytes(input));
			var lexer = new TuringLexer(new AntlrInputStream(ms));

			var tokens = new CommonTokenStream(lexer);

			var parser = new TuringParser(tokens);

			var tree = parser.file();

			var pastwk = new ParseTreeWalker();

			pastwk.Walk(new TuringMegaListener(args[1]), tree);

		}
	}
}
