using System;
using System.IO;
using System.Linq;

namespace TuringTranslator
{
	public class TuringMegaListener : TuringBaseListener
	{
		readonly string OutputFilename;
		StreamWriter OutputWriter;

		string MainFunctionOutput = "";

		bool InFunction = true;

		public TuringMegaListener(string outputFilename)
		{
			OutputFilename = outputFilename;

			OutputWriter = new StreamWriter(File.Open(OutputFilename, FileMode.Create));
			OutputWriter.AutoFlush = true;
		}

		void Out(string s)
		{
			if(InFunction) {
				OutputWriter.Write(s);
			}
			else {
				MainFunctionOutput += s;
			}
		}

		void OutLine(string s)
		{
			if(InFunction) {
				OutputWriter.WriteLine(s);
			}
			else {
				MainFunctionOutput += s + "\n";
			}
		}

		void PrintErrorAndExit(int error_code, string message)
		{
			Console.WriteLine($"Error {error_code}: {message}");

			OutputWriter.Close();
			File.Delete(OutputFilename);

			Environment.Exit(1);
		}

		public override void EnterFile(TuringParser.FileContext context)
		{
            OutLine("using System;");
			OutLine("");
			OutLine("class Program {");

			InFunction = false;
		}

		public override void ExitFile(TuringParser.FileContext context)
		{
			InFunction = true;

			OutLine("public static void Main() {");

			OutLine(MainFunctionOutput);

            OutLine("}");

			OutLine("}");
		}

		string PrintExpression(TuringParser.ExpressionContext context)
		{
			return context.GetText().Replace("=", "==");
		}

		public override void EnterFunctionDecl(TuringParser.FunctionDeclContext context)
		{
			if(context.ID()[0].GetText() != context.ID()[1].GetText()) {
				PrintErrorAndExit(1001, $"Two function ids `{context.ID()[0].GetText()}`" +
				                  $" and `{context.ID()[1].GetText()}` don't match in function declaration");
			}

			InFunction = true;

			string paramString = String.Join(",", context.formalParam().Select(param => "int " + param.ID().GetText()));

			OutLine($"static int {context.ID()[0].GetText()} ({paramString}) {{");
		}

		public override void ExitFunctionDecl(TuringParser.FunctionDeclContext context)
		{
			OutLine("}");

			InFunction = false;
		}

		public override void EnterAssignmentStmt(TuringParser.AssignmentStmtContext context)
		{
			OutLine($"{context.ID().GetText()} = {PrintExpression(context.expression())};");
		}

		public override void EnterReturnStmt(TuringParser.ReturnStmtContext context)
		{
			OutLine($"return {PrintExpression(context.expression())};");
		}

		public override void EnterVariableDeclStmt(TuringParser.VariableDeclStmtContext context)
		{
			OutLine($"int {context.ID().GetText()};");
		}

		public override void EnterConditionalStmt(TuringParser.ConditionalStmtContext context)
		{
			OutLine($"if({PrintExpression(context.expression())}) {{");
		}

		public override void ExitConditionalStmt(TuringParser.ConditionalStmtContext context)
		{
			OutLine("}");
		}

		public override void EnterElse(TuringParser.ElseContext context)
		{
			OutLine("}");
			OutLine("else {");
		}

		public override void EnterPutStmt(TuringParser.PutStmtContext context)
		{
			foreach(var expression in context.expression()) {
				OutLine($"Console.Write({PrintExpression(expression)});");
			}

			OutLine("Console.WriteLine();");
		}
	}
}
