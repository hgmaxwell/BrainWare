using System.Data;
using System.Data.SqlClient;

namespace Api.Abstractions;

public interface IDatabaseAdapter
{
    DataTable ExecuteStoredProcedure(string storedProcedureName, SqlParameter[] parameters);
    void Dispose();
}