// See https://aka.ms/new-console-template for more information
using DbUp;
using DbUp.Downgrade;
using Microsoft.Extensions.Configuration;
using System.Reflection;

Console.WriteLine("Going to execute Embdded Resource Scripts");

//static int Main(string[] args)
//{
IConfiguration config = new ConfigurationBuilder()
    .AddJsonFile("appsettings.json")
    .AddEnvironmentVariables()
    .Build();


var connectionString =
        args.FirstOrDefault()
        ?? config.GetConnectionString("DbCoreConnectionString");

    var upgrader =
        DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
            //.WithScriptsAndDowngradeScriptsEmbeddedInAssembly<SqlDowngradeEnabledTableJournal>(Assembly.GetExecutingAssembly(), DowngradeScriptsSettings.FromFolder())
            .LogToConsole()
            //.WithTransaction()
            .Build();
//.BuildWithDowngrade(true);

var result = upgrader.PerformUpgrade();

    if (!result.Successful)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine(result.Error);
        Console.ResetColor();
#if DEBUG
        Console.ReadLine();
#endif                
        return -1;
    }

    Console.ForegroundColor = ConsoleColor.Green;
    Console.WriteLine("Success!");
    Console.ResetColor();
    return 0;
//}