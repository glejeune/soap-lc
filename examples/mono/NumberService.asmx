<%@ WebService Language="C#" Class="MathService.MathService" %>
 
using System;
using System.Web.Services;
 
namespace MathService
{
	[WebService (Namespace = "http://tempuri.org/NumberService")]
	public class MathService : WebService
	{
		[WebMethod]
		public int AddNumbers (int number1, int number2)
		{
			return number1 + number2;
		}
 
		[WebMethod]
		public int SubtractNumbers (int number1, int number2)
		{
			return number1 - number2;
		}
		
		[WebMethod]
		public string HelloWorld( )
		{
			return "Hello World!";
		}
	}
}