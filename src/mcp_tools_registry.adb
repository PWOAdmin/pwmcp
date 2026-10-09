with Mcp_Response;

package body Mcp_Tools_Registry is
   use GNATCOLL;
   procedure Register_Tool
     (Tool : Mcp_Tool.Mcp_Tool_Type'class) is
   begin
      Registry.Append (Tool);
   end Register_Tool;

   function Create_Tools_JSON_Response
     (Id : Integer) return GNATCOLL.JSON.JSON_Value
   is
      Resp       : Mcp_Response.Mcp_Response_Type := (Id => Id);
      Val        : JSON.JSON_Value := Resp.To_JSON;
      Result     : Json.Json_Value := JSON.Create_Object;
      Tool_Array : JSON.JSON_Array;
   begin
      for Tool of Registry loop
         declare
            Tool_Obj : Json.JSON_Value := Mcp_Tool.Tool_JSON (Tool);
         begin
            JSON.Append (Tool_Array, Tool_Obj);
         end;
      end loop;
      Result.Set_Field ("tools", Tool_Array);
      Val.Set_Field ("result", Result);
      return Val;
   end Create_Tools_JSON_Response;

end Mcp_Tools_Registry;
