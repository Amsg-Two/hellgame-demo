using Godot;
using System;
using System.IO;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text.RegularExpressions;

public partial class DmonParser : Node
{
	public static string commandDefinition(List<string> block)
	{
		string retval = "[";
//          Regex bracketmatcher = new Regex(@"[\[][^\[]*[\]]");
		string cmdName = block[0].Split(' ')[1];
		block.RemoveAt(0);
		string last = block[block.Count() - 2];
		foreach (string line in block)
		{
			string miniret = "";
			if (line == "END")
			{
				break;
			}
			else
			{
				string[] narr;
				string[] yarr;
				if (line.Contains('['))
				{
					narr = line.Substring(0, line.IndexOf('[')).Split(' ');
					yarr = line.Substring(line.IndexOf('[')).Split(',');
				}
				else
				{
					narr = line.Split(' ');
					yarr = new string[0];
				}
				miniret += "[\"" + narr[0] + "\",[";
				foreach (string keyword in narr.Skip(1))
				{
					if (keyword != "")
					{
						if (keyword.Contains(":") && !keyword.StartsWith(":"))
						{
							int cd = keyword.IndexOf(":");
							miniret += "[\"" + keyword.Substring(0, cd) + "\",\"" + keyword.Substring(cd + 1) + "\"],";
						}
						else if (keyword.Contains(":"))
						{
							miniret += "\"" + keyword + "\",";
						}
						else if (keyword == "^")
						{
							miniret += "\"^\",";
						}
						else if (keyword.StartsWith("*"))
						{
							miniret += "\"" + keyword + "\",";
						}
						else
						{
							Console.WriteLine("Unrecognized keyword " + keyword);
						}
						if (Array.IndexOf(narr.Skip(1).ToArray(), keyword) == narr.Count() - 2)
						{
							miniret = miniret.TrimEnd(',');
						}
					}
				}
				if (yarr.Count() > 0 && !yarr.Contains("[NONE]"))
				{
					miniret += String.Join(", ", yarr);
				}
				else if (yarr.Count() > 0 && yarr.Contains("[NONE]"))
				{
					miniret += "[null]";
				}
				miniret += "]";
			}
			retval += miniret + "]";
			if (line != last)
			{
				retval += ",";
			}
		}
		return retval + "]";
	}
	
	public static string prepDmonString(string filepath)
	{
		string netret = "{";
		var breaklist = new List<List<string>>();
		int breakdex = 0;
		breaklist.Add(new List<string>());
		foreach (string line in File.ReadLines(filepath))
		{
			if (line.Length == 0)
			{
				breakdex += 1;
				breaklist.Add(new List<string>());
			}
			else
			{
				breaklist[breakdex].Add(line);
			}
		}
		foreach (var block in breaklist)
		{
			if (breaklist[0][0].Substring(1, 6) == "ACTSET")
			{
				string blocktype = block[0].Split(' ')[0];
				if (blocktype == "DEFINE")
				{
					netret += "\"" + block[0].Split(' ')[1] + "\":";
					netret += commandDefinition(block);
					if (breaklist.IndexOf(block) != breaklist.Count() - 1)
					{
						netret += ",";
					}
				}
			}
			else if (breaklist[0][0].Substring(1, 6) == "UNIDAT")
			{
				Console.WriteLine("Define unit data handler here");
			}
		}
		netret += "}";
		return netret;
	}
}
