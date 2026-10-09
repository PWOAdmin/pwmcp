with PW_Config;
package Mcp_Server_Info is

   use PW_Config;

   type Mcp_Server_Info_Type is record
      Server_Name    : Mcp_String;
      Server_Title   : Mcp_String;
      Server_Version : Mcp_String;
      Id:Integer;
   end record;

   
end Mcp_Server_Info;