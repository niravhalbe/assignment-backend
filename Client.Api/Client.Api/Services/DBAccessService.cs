using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Client.Api.Services
{
    public static class DBAccessService
    {
        static IDbConnection db = new SqlConnection(Convert.ToString(ConfigurationManager.AppSettings["ConnectionString"]));

        public static List<T> GetMultipleResults<T>(string procedureName, DynamicParameters parameters)
        {
            List<T> list = new List<T>();
            using (IDbConnection db = GetSQLConnection())
            {
                var multipleResult = db.QueryMultiple(procedureName, parameters, commandType: CommandType.StoredProcedure);
                var data = multipleResult.Read<T>().ToList();
                list.AddRange(data);
            }
            return list;
        }

        public static T GetSingleResult<T>(string procedureName, DynamicParameters parameters)
        {
            T t;
            using (IDbConnection db = GetSQLConnection())
            {
                var singleResult = db.QuerySingle<T>(procedureName, parameters, commandType: CommandType.StoredProcedure);
                t = singleResult;
            }
            return t;
        }

        public static int Execute(string procedureName, DynamicParameters parameters)
        {
            int result;
            using (IDbConnection db = GetSQLConnection())
            {
                result = db.Execute(procedureName, parameters, commandType: CommandType.StoredProcedure);
            }
            return result;
        }

        private static SqlConnection GetSQLConnection()
        {
            return new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        }

    }
}