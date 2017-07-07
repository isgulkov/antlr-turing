using System;
namespace TuringTranslator
{
	public class TuringMegaListener : TuringBaseListener
	{
		string OutputFilename;

		public TuringMegaListener(string outputFilename)
		{
			OutputFilename = outputFilename;
		}
	}
}
