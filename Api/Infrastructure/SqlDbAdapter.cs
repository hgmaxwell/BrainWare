using Api.Abstractions;
using System.Data;
using System.Data.SqlClient;

namespace Api.Infrastructure;

public class SqlDbAdapter : IDisposable, IDatabaseAdapter
{
    private readonly SqlConnection _connection;

    public SqlDbAdapter(IDbConnection connection)
    {
        _connection = (SqlConnection)connection;
    }

    public DataTable ExecuteStoredProcedure(string storedProcedureName, SqlParameter[] parameters)
    {
        _connection.Open();
        using var command = new SqlCommand(storedProcedureName, _connection);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddRange(parameters);

        using var adapter = new SqlDataAdapter(command);
        var result = new DataTable();
        adapter.Fill(result);
        _connection.Close();

        return result;
    }

    public void Dispose()
    {
        if (_connection.State != ConnectionState.Closed)
        {
            _connection.Close();
        }

        _connection.Dispose();
    }
}