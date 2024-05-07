using System;
using System.Collecions.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Perceptron
{	// compuerta logica and

class Program
{

static void Main(string[] args)
    {
        int[,]datos = {{1,1,1}, {1,0,0},{0,1,0},{0,0,0}};
        Random aleatorio = new Random();
        double[] pesos = {aleatorio.NextDouble(), aleatorio.NextDoble(),aleatorio.NextDoble()}
        bool entrenamiento = True;	
        int salidaInt;
     while (entrenamiento)
        {
             entrenamiento = false;
            for (int i = 0; i < 4; i++)
                {
                 double salidaDoub = datos[i,0] * pesos[0] + datos[i,0] * pesos[1] + pesos[2];
                if(salidaDoub > 0) salidaInt = 1;
                else salidaInt = 0;
            if(salidaInt !=  datos[1,2])
                {
                    pesos[0] = aleatorios.NextDouble() - aleatorio.NextDouble()
                    pesos[1] = aleatorios.NextDouble() - aleatorio.NextDouble()
                    pesos[2] = aleatorios.NextDouble() - aleatorio.NextDouble()
                    entrenamiento = true;
                }
            }
    
        }
        //fin entrenamiento
        Console.WriteLine("pesos utilies: w0 = "+ pesos[0].ToString() +"w1 = "+ pesos[1].ToString() + "w2 = "+ pesos[2].ToString() + );
        Console.ReadLine();
        for (int i = 0; i < 4; i++)
        {
            double salidaDoub =  double salidaDoub = datos[i,0] * pesos[0] + datos[i,0] * pesos[1] + pesos[2];
            if (salidaDoub > 0) salidaInt = 1;
            else salidaInt = 0;
            Console.WriteLine("Entradas: " +datos[i,0].ToString() + "AND: " +datos[i,1].ToString() + "= " +datos[i,2].ToString() + "| perceptron: " + salidaInt.ToString()
        }
    }

}

}