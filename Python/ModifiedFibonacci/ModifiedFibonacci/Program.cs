using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Numerics;


namespace ModifiedFibonacci
{
    class Program
    {
        static void Main(string[] args)
        {
            //BigInteger value;
            UInt64[] sequence = new UInt64[21];
            UInt64 a, b, n;

            string input = Console.ReadLine();

            string[] cheese = input.Split(' ');            
            if (0 <= int.Parse(cheese[0]) && int.Parse(cheese[1]) <= 2 && 3 <= int.Parse(cheese[2]) && int.Parse(cheese[2]) <= 20)
            {
                a = UInt64.Parse(cheese[0]);
                b = UInt64.Parse(cheese[1]);
                n = UInt64.Parse(cheese[2]);

                sequence[0] = a;
                sequence[1] = b;
            
                for (int i = 2; i < sequence.Length; i++)
                {
                    sequence[i] = (sequence[i - 1] * sequence[i - 1]) + sequence[i - 2];
           //       sequence[i] = new BigInteger 
                }

                Console.WriteLine(sequence[n - 1].ToString());
                Console.ReadLine();
            }
        }
    }
}
