using System;
using System.Collections.Generic;
using System.Linq;

namespace Compression
{
    class Program
    {
        static void Main(string[] args)
        {
            
            string alice = "";
            using (var sr = new System.IO.StreamReader(Environment.GetFolderPath(Environment.SpecialFolder.Personal) + "/alice.txt"))
            {
                alice = sr.ReadToEnd().ToUpper();
            }
            string sanitizedAlice = "";
            char[] alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ".ToCharArray();
            foreach(char c in alice)
            {
                if (alphabet.Contains(c))
                {
                    sanitizedAlice += c;
                }
            }

            string[] messages = new string[]{
                "REMEMBER TO DRINK YOUR OVALTINE",
                "GIANTS BEAT DODGERS 10 TO 9 AND PLAY TOMORROW AT 1300",
                "SPACE THE FINAL FRONTIER THESE ARE THE VOYAGES OF THE BIT STREAM DAILY PROGRAMMER TO SEEK OUT NEW COMPRESSION",
                alice,
                sanitizedAlice
            };
            

            foreach (string input in messages)
            {
                int inLen = StringToBytes(input).Length;
                byte[] compressed = Compress(input);
                int compressionRatio = 100 - ((100 * compressed.Length)/ inLen);
                string decompressed = Decompress(compressed);
                int outLen = StringToBytes(decompressed).Length;

                //Console.WriteLine("Message: {0}", input);
                Console.WriteLine("Read message of {0} bytes.", inLen);
                Console.WriteLine("Compressing {0} bits into {1} bits. ({2}% compression)", inLen * 8, compressed.Length * 8, compressionRatio);
                Console.WriteLine("Sending Message.");
                Console.WriteLine("Decompressing Message into {0} bytes.", outLen );
                Console.WriteLine(input.Equals(decompressed) ? "Message Match!" : "Something went wrong! (Messages don't match)" );
                Console.WriteLine();
            }
            Console.ReadLine();
        }

        #region Wordlist
        //256 entries
        private static string[] wordlist = new string[]{
            ((char)(byte)0).ToString(),
            "THE",
            "AND",
            "HAVE",
            "THAT",
            "FOR",
            "YOU",
            "WITH",
            "SAY",
            "THIS",
            "THEY",
            "BUT",
            "HIS",
            "FROM",
            "THAT",
            "NOT",
            "SHE",
            "WHAT",
            "THEIR",
            "CAN",
            "WHO",
            "GET",
            "WOULD",
            "HER",
            "ALL",
            "MAKE",
            "ABOUT",
            "KNOW",
            "WILL",
            "ONE",
            "TIME",
            "THERE",
            "YEAR",
            "THINK",
            "WHEN",
            "WHICH",
            "THEM",
            "SOME",
            "PEOPLE",
            "TAKE",
            "OUT",
            "INTO",
            "JUST",
            "SEE",
            "HIM",
            "YOUR",
            "COME",
            "COULD",
            "NOW",
            "THAN",
            "LIKE",
            "OTHER",
            "HOW",
            "THEN",
            "ITS",
            "OUR",
            "TWO",
            "MORE",
            "THESE",
            "WANT",
            "WAY",
            "LOOK",
            "FIRST",
            "ALSO",
            "NEW",
            "BECAUSE",
            "DAY",
            "MORE",
            "USE",
            "MAN",
            "FIND",
            "HERE",
            "THING",
            "GIVE",
            "MANY",
            "WELL",
            "ONLY",
            "THOSE",
            "TELL",
            "ONE",
            "VERY",
            "HER",
            "EVEN",
            "BACK",
            "ANY",
            "GOOD",
            "WOMAN",
            "THROUGH",
            "LIFE",
            "CHILD",
            "THERE",
            "WORK",
            "DOWN",
            "MAY",
            "AFTER",
            "SHOULD",
            "CALL",
            "WORLD",
            "OVER",
            "SCHOOL",
            "STILL",
            "TRY",
            "LAST",
            "ASK",
            "NEED",
            "TOO",
            "FEEL",
            "THREE",
            "WHEN",
            "STATE",
            "NEVER",
            "BECOME",
            "BETWEEN",
            "HIGH",
            "REALLY",
            "SOMETHING",
            "MOST",
            "ANOTHER",
            "MUCH",
            "FAMILY",
            "OWN",
            "OUT",
            "LEAVE",
            "PUT",
            "OLD",
            "WHILE",
            "MEAN",
            "KEEP",
            "STUDENT",
            "WHY",
            "LET",
            "GREAT",
            "SAME",
            "BIG",
            "GROUP",
            "BEGIN",
            "SEEM",
            "COUNTRY",
            "HELP",
            "TALK",
            "WHERE",
            "TURN",
            "PROBLEM",
            "EVERY",
            "START",
            "HAND",
            "MIGHT",
            "AMERICAN",
            "SHOW",
            "PART",
            "ABOUT",
            "AGAINST",
            "PLACE",
            "OVER",
            "SUCH",
            "AGAIN",
            "FEW",
            "CASE",
            "MOST",
            "WEEK",
            "COMPANY",
            "WHERE",
            "SYSTEM",
            "EACH",
            "RIGHT",
            "PROGRAM",
            "HEAR",
            "QUESTION",
            "DURING",
            "WORK",
            "PLAY",
            "GOVERNMENT",
            "RUN",
            "SMALL",
            "NUMBER",
            "OFF",
            "ALWAYS",
            "MOVE",
            "LIKE",
            "NIGHT",
            "LIVE",
            "POINT",
            "BELIEVE",
            "HOLD",
            "TODAY",
            "BRING",
            "HAPPEN",
            "NEXT",
            "WITHOUT",
            "BEFORE",
            "LARGE",
            "ALL",
            "MILLION",
            "MUST",
            "HOME",
            "UNDER",
            "WATER",
            "ROOM",
            "WRITE",
            "MOTHER",
            "AREA",
            "NATIONAL",
            "MONEY",
            "STORY",
            "YOUNG",
            "FACT",
            "MONTH",
            "DIFFERENT",
            "LOT",
            "RIGHT",
            "STUDY",
            "BOOK",
            "EYE",
            "JOB",
            "WORD",
            "THOUGH",
            "BUSINESS",
            "ISSUE",
            "SIDE",
            "KIND",
            "FOUR",
            "HEAD",
            "FAR",
            "BLACK",
            "LONG",
            "BOTH",
            "LITTLE",
            "HOUSE",
            "YES",
            "AFTER",
            "SINCE",
            "LONG",
            "PROVIDE",
            "SERVICE",
            "AROUND",
            "FRIEND",
            "IMPORTANT",
            "FATHER",
            "SIT",
            "AWAY",
            "UNTIL",
            "POWER",
            "HOUR",
            "GAME",
            "OFTEN",
            "YET",
            "LINE",
            "POLITICAL",
            "END",
            "AMONG",
            "EVER",
            "STAND",
            "BAD",
            "LOSE",
            "HOWEVER",
            "MEMBER"
        };
        #endregion

        private static byte[] StringToBytes(string input)
        {
            byte[] output = new byte[input.Length];
            int index = 0;
            foreach (char c in input)
            {
                output[index++] = (byte)c;
            }
            return output;
        }

        private static byte[] Compress(string input)
        {
            List<byte> compressed = new List<byte>();
            string[] words = input.Split(' ');
            foreach (string word in words)
            {
                if (wordlist.Contains(word))
                {
                    compressed.Add((byte)0);
                    compressed.Add((byte)Array.IndexOf(wordlist, word));
                }
                else
                {
                    foreach (char c in word)
                    {
                        compressed.Add((byte)c);
                    }
                }
                compressed.Add((byte)' ');
            }
            compressed.RemoveAt(compressed.Count - 1);
            return compressed.ToArray();
        }

        private static string Decompress(byte[] input)
        {
            string output = "";
            for (int i = 0; i < input.Length; i++)
            {
                if (input[i] == 0)
                {
                    output += wordlist[input[++i]];
                }
                else
                {
                    output += (char)input[i];
                }
            }
            return output;
        }
    }
}
