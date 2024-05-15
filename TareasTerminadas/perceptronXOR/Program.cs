using System;

namespace PerceptronXOR
{
    class Program
    {
        static void Main(string[] args)
        {
            double[,] datos = { { 0, 0, 0 }, { 0, 1, 1 }, { 1, 0, 1 }, { 1, 1, 0 } };
            Random aleatorio = new Random();
            
            // pesos y umbrales
            double[] pesosCapaOculta1 = { aleatorio.NextDouble(), aleatorio.NextDouble(), aleatorio.NextDouble() };
            double[] pesosCapaOculta2 = { aleatorio.NextDouble(), aleatorio.NextDouble(), aleatorio.NextDouble() };
            double[] pesosSalida = { aleatorio.NextDouble(), aleatorio.NextDouble(), aleatorio.NextDouble() };

            double tasaAprendizaje = 0.1;
            int epocas = 10000;

            for (int epoca = 0; epoca < epocas; epoca++)
            {
                for (int i = 0; i < datos.GetLength(0); i++)
                {
                   
                    double z1 = datos[i, 0] * pesosCapaOculta1[0] + datos[i, 1] * pesosCapaOculta1[1] + pesosCapaOculta1[2];
                    double z2 = datos[i, 0] * pesosCapaOculta2[0] + datos[i, 1] * pesosCapaOculta2[1] + pesosCapaOculta2[2];
                    double salidaCapaOculta1 = FuncionActivacion(z1);
                    double salidaCapaOculta2 = FuncionActivacion(z2);

                    double zSalida = salidaCapaOculta1 * pesosSalida[0] + salidaCapaOculta2 * pesosSalida[1] + pesosSalida[2];
                    double salida = FuncionActivacion(zSalida);

                    // Cálculo del error
                    double error = datos[i, 2] - salida;

                    // Retropropagación del error  y ajuste de pesos
                    double deltaSalida = error * DerivadaFuncionActivacion(zSalida);
                    pesosSalida[0] += tasaAprendizaje * deltaSalida * salidaCapaOculta1;
                    pesosSalida[1] += tasaAprendizaje * deltaSalida * salidaCapaOculta2;
                    pesosSalida[2] += tasaAprendizaje * deltaSalida;

                    double errorCapaOculta1 = deltaSalida * pesosSalida[0];
                    double errorCapaOculta2 = deltaSalida * pesosSalida[1];

                    double deltaCapaOculta1 = errorCapaOculta1 * DerivadaFuncionActivacion(z1);
                    double deltaCapaOculta2 = errorCapaOculta2 * DerivadaFuncionActivacion(z2);

                    pesosCapaOculta1[0] += tasaAprendizaje * deltaCapaOculta1 * datos[i, 0];
                    pesosCapaOculta1[1] += tasaAprendizaje * deltaCapaOculta1 * datos[i, 1];
                    pesosCapaOculta1[2] += tasaAprendizaje * deltaCapaOculta1;

                    pesosCapaOculta2[0] += tasaAprendizaje * deltaCapaOculta2 * datos[i, 0];
                    pesosCapaOculta2[1] += tasaAprendizaje * deltaCapaOculta2 * datos[i, 1];
                    pesosCapaOculta2[2] += tasaAprendizaje * deltaCapaOculta2;
                }
            }

            // Prueba de  red con todas las combinaciones posibles
            for (int i = 0; i < datos.GetLength(0); i++)
            {
                double z1 = datos[i, 0] * pesosCapaOculta1[0] + datos[i, 1] * pesosCapaOculta1[1] + pesosCapaOculta1[2];
                double z2 = datos[i, 0] * pesosCapaOculta2[0] + datos[i, 1] * pesosCapaOculta2[1] + pesosCapaOculta2[2];
                double salidaCapaOculta1 = FuncionActivacion(z1);
                double salidaCapaOculta2 = FuncionActivacion(z2);

                double zSalida = salidaCapaOculta1 * pesosSalida[0] + salidaCapaOculta2 * pesosSalida[1] + pesosSalida[2];
                double salida = FuncionActivacion(zSalida);
                int salidaInt = salida > 0.5 ? 1 : 0;

                Console.WriteLine($"Entradas: {datos[i, 0]}, {datos[i, 1]} = {datos[i, 2]} | Perceptrón: {salidaInt}");
            }

            Console.ReadLine();
        }

        static double FuncionActivacion(double x)
        {
            return 1 / (1 + Math.Exp(-x)); // Función sigmoide
        }

        static double DerivadaFuncionActivacion(double x)
        {
            double sigmoid = 1 / (1 + Math.Exp(-x));
            return sigmoid * (1 - sigmoid); // Derivada de sigmoide
        }
    }
}