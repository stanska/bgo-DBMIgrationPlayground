# [DbUp](https://dbup.readthedocs.io/en/latest/) Migration Playground

A sample [DbUp](https://dbup.readthedocs.io/en/latest/) playground console application with the popular [Northwind database](./InitialLoad/NorthwindCreation.sql) database.
TODO: create DB and generate model? Is this possible, or stick with the curernt example
You run the application and the already [Embedded Resource scripts](./Scripts) will be uploaded to the DB configured in the [appsettings.json](./appsettings.json)
You can always delete the db by [executing the pregenerated drop script](./InitialLoad/drop_DB.sql). 

### Quick Start
Edit the connection string in appsettins.json and run:

```powershell
cd DBUpMigrationPlayground
dotnet build
dotnet run
```

## DbUp vs EF Migrations
EF Core provides ways of keeping your EF model and database in sync. But if you project does not use EF Core you cannot benefit from EF migrations.
In case you are using different technology for ORM, like [DevExpres XPO](https://www.devexpress.com/products/net/orm/), you can use DbUp.

When doing DB migrations, always be mindful not to lose data. For example, XPO supports [migration mechanism](https://community.devexpress.com/blogs/xpo/archive/2020/04/20/xpo-automate-database-schema-migrations-using-the-orm-data-model-designer-or-apis-ctp.aspx),
but it is specified 

```quote
If you rename a class or property, the schema migration script will delete the corresponding table or column and create a new one. 
```

For comparison, EF Core renames in place a table and a column - data will not be lost.

DbUp does not count on ORM model out of which a migration is generated, but gives you freedom and is technology agnostic.


### [DbUp Philosophy](https://dbup.readthedocs.io/en/latest/philosophy-behind-dbup/)

The philosophy behind DbUp is DB evolves in transitions. And by keeping the transitions, DB can be recreated.
If we are starting to use DB for an existing project, we need an initial transition, initial state from where the DB will continue to evolve.

### Generate Initial State Script

SQL Server Management Studio does provide tools to assist with this, but it  may took a while to get all the right settings to export things in a way that would allow DbUp to repeatedly apply these changes without error.

Right click on the **database**, select tasks, **Generate scripts**
Select which ones you want (procs, functions, views, etc).
Select tables, views, procedures separately and keep them in a separate file.

On the output path selection page, click on **Advanced**. 
There are two important settings you need to be careful of:

+ Set Script USE DATABASE = false if you want to specify the DB upfront as a parameter
+ Check for object existence = true
+ Chose CREATE or DROP script. Store them separately, the down script is helpful for rolling back state. 
+ Data can be generated as part of the create table option. The option to include data inserts is **Types of data to script** -> **Data only**.

For easier diff you can select **Save as** ANSI text.


### Naming conventions are always helpful
TODO:PascalCase or snake_case naming convention

+ [Scripts/Up/00001.create_tables_initial_state.sql](./Scripts/00001.create_tables_initial_state.sql)
+ [Scripts/Up/00002.create_views_initial_state.sql](./Scripts/00002.create_views_initial_state.sql)
+ [Scripts/Up/00003.create_data_initial_state.sql](./Scripts/00003.create_data_initial_state.sql)
+ [Scripts/Up/00004.create_foreign_keys_initial_state.sql](./Scripts/00004.create_foreign_keys_initial_state.sql)
+ [Scripts/Up/00005.create_stored_procedures_initial_state.sql](./Scripts/00005.create_stored_procedures_initial_state.sql)

If you have table constraints, extract the create table statements to execute them separately, in order to have smooth data insertion, without constraints error.

1.Foreign keys are generated below table creation in the generated create table script. You can extract the foreing keys in a separate sql file. 

2.Data can be inserted without constraint errors from the data script already generated.

3.After the data is inserted, the foreign keys can be created.

To guarantee script executution order, prefix the files with a number. Files are lexicographically ordered upon exection. Note: We have zeros in front, to guarantee for ex: 4 will be before 11.

Upload/Scripts and Rollback/Downgrade scripts can be created in separate folders.

### TODO:Generate Scripts from the command line
Since script extraction is performed only on initial transition generation, we may start with Sql Management Studio Studio Wizard Integraion and generate scripts from command line if the scripts generation process is needed to be automatic.


### Add DbUp as dependancy

```powershell
dotnet add package dbup
```

### Create You first transition

After we have the initial state, we are ready to make the transition script files.

Place the Upload transitions in a Scrits subfolder, you can have different folders as EmbeddedResource scripts
, but mind the execution order as sorting the sql files path lexicographically.

For example, I have crated scrit [Scripts/00006.alter_employeeTerritires_add_NewColumn_table.sql](./Scripts/00006.alter_employeeTerritires_add_NewColumn_table.sql) to add a new column to a table. 
Again, naming convetions can be useful:
+ If you are adding a new table — {TransitionVersion}.create_table_{table name}_{why it is created}
+ If you are rename Name a column to BlogName — {TransitionVersion}.alter_table_rename_{old name}_to_{new name}
+ If you are adding more than one table, the name of the feature or some other composite name can be used — {TransitionVersion}.create_table_{why tables are added, i.e. jira story or smth}
+ If you are adding a new column NewColumn to a table Blog — {TransitionVersion}.alter_table_{table name}_{what is altered}
+ If you are adding a view - {TransitionVersion}.create_view_{view name}_{why it is created}
+ If you are alter a view - {TransitionVersion}.alter_view_{view name}_{what it is altered}
+ If you are seeding data — {TransitionVersion}.create_data_{what data is added}
TODO: Resolve the case and unify it in all places


### Execite Migration
All sql scripts should have a property **Build** -> **Embedded Resource**.
In the [Program.cs](./Program.cs) file you can execute the embdedded resources in the following way.
```csharp
var connectionString =
        args.FirstOrDefault()
        ?? "Server=.;Database=Northwind;Trusted_Connection=true;TrustServerCertificate=True;";

    var upgrader =
        DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
            .LogToConsole()
            .Build();

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
```

Migrations can be run as a separate project as a console application, or can be performed on startup.
### [Execute Transactions](https://dbup.readthedocs.io/en/latest/more-info/transactions/)
There are three types of transactions supported:

+ No Transactions (default) - builder.WithoutTransaction()
+ Transaction per script - builder.WithTransactionPerScript()
+ Single transaction - builder.WithTransaction()

### Automatic Downgrade on Failure
Our fellow worker Atanas Simeonov, has already [extended DbUp](https://github.com/asimeonov/DbUp.Downgrade) to  downgrade changes already executed by a script.
In order to downgrade/rollback a given version, you have to create a downgrade script before script is applied. The script should be: 
 + with the same name in a **Downgrade** folder 
 + OR
 + with a **downgrade** suffix
as described in the [documentation](https://github.com/asimeonov/DbUp.Downgrade). 

In order to revert a script, on demand, instead of
```csharp
    var upgrader =
        DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
            .LogToConsole()
            .WithTransaction()
            .Build();
```
you should run

    var upgrader =
        DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsAndDowngradeScriptsEmbeddedInAssembly<SqlDowngradeEnabledTableJournal>(Assembly.GetExecutingAssembly(), DowngradeScriptsSettings.FromFolder())
            .LogToConsole()
            .WithTransaction()
            .BuildWithDowngrade(true);
You can test this feature by marking [./Scripts/00008.alter_employeeTerritires_add_NewColumn_ExceptionWithDowngrade.sql](./Scripts/00008.alter_employeeTerritires_add_NewColumn_ExceptionWithDowngrade.sql) as Embedded Resource.
### [Filter Migrations](https://elanderson.net/2020/08/always-run-migrations-with-dbup/)
You can filter which migrations should run always or not by using filters

#### Skip Run

```csharp
var upgrader =
    DeployChanges.To
                 .SqlDatabase(connectionString)
                 .WithScriptsAndCodeEmbeddedInAssembly(Assembly.GetExecutingAssembly(),
                                                       f => !f.Contains(".SkilRun."))
                 .LogToConsole()
                 .Build();
var result = upgrader.PerformUpgrade();
```


#### Always Run

You can filter which migrations should run always or not by using filters. To accomplish this we add a second upgrader that is filtered just to AlwaysRun scripts. The second really important bit about this second upgrader is that it uses a NullJournal. The NullJournal is what keeps the execution of the scripts from being logged which results in them always getting run. The following code was inserted after the above code. The highlighted bits point out the filter and null journal.

```csharp
if (result.Successful)
{
    var alwaysRunUpgrader =
        DeployChanges.To
                     .SqlDatabase(connectionString)
                     .WithScriptsAndCodeEmbeddedInAssembly(Assembly.GetExecutingAssembly(),
                                                           f => f.Contains(".AlwaysRun."))
                     .JournalTo(new NullJournal())
                     .LogToConsole()
                     .Build();
    result = alwaysRunUpgrader.PerformUpgrade();
}
```

### DbUp Schema Versions Table
All scripts run are kept in **SchemaVersions** table. If you don't want to start from scratch, don't drop this table.

Scripts 
**Note**: If you change the script folder/name, the script will be treated as a new one and will be executed again upon run. Good practice is to create the script as idempotent onse, i.e. check for existance before create/insert.
Example: [00007.alter_employeeTerritires_add_NewColumn_IdempotentScript.sql](./Scripts/00007.alter_employeeTerritires_add_NewColumn_IdempotentScript.sql)

### On Startup Migration
You can setup migrations scripts to be executed upon server startup, or you can have it as a console application as in this sample playground.
TODO: Add the upgrader code in a IStartupFilter implementation class as described in https://medium.com/cheranga/database-migrations-using-dbup-in-an-asp-net-core-web-api-application-c24ccfe0cb43

### CI/CD &  Production Migration
Database migration can be executed on any build in the correct environment order. For ex: TEST, INTEGRATION, STAGE, PRODUCTION.
Deploy to a subsequent environment can be proceeded if all tests on the preceeding environment have already passed.
