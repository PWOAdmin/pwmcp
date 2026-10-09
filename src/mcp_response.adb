with GNATCOLL.JSON;
with PW_Config;

package body MCP_Response is
   use GNATCOLL;

   function To_JSON (Response : Mcp_Response_Type'Class) return JSON.JSON_Value is
      Res : JSON.JSON_Value := JSON.Create_Object;
   begin
      JSON.Set_Field (Res, "jsonrpc", PW_Config.JSONRPC_VERSION);
      JSON.Set_Field (Res, "id", Response.Id);
      return Res;
   end To_JSON;

end MCP_Response;
