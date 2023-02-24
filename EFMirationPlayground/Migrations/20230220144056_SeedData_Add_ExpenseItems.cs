﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace EMigrationPlayground.Migrations
{
    /// <inheritdoc />
    public partial class SeedData_Add_ExpenseItems : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.InsertData(
                table: "ExpenseItems",
                columns: new[] { "Id", "Category", "Name" },
                values: new object[,]
                {
                    { 1, "Big Expense", "Ferrari" },
                    { 2, "Small Expense", "Cheese" },
                    { 3, "Mid Expense", "TV" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "ExpenseItems",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "ExpenseItems",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "ExpenseItems",
                keyColumn: "Id",
                keyValue: 3);
        }
    }
}
