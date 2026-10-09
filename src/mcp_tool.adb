package body Mcp_Tool is
   use GNATCOLL;

   package R renames PW_Config.MCP_Record_Fields;
   function "=" (Left, Right : Tool_Property_Type) return Boolean is
   begin
      return
        R.To_String (Left.Property_Name) = R.To_String (Right.Property_Name);
   end "=";

   function "=" (Left, Right : Mcp_Tool_Type) return Boolean is
   begin
      return R.To_String (Left.Name) = R.To_String (Right.Name);
   end "=";

   function Property_JSON
     (Prop : Tool_Property_Type) return GNATCOLL.JSON.Json_Value
   is

      Val : JSON.Json_Value := JSON.Create_Object;
   begin
      Val.Set_Field ("type", R.To_String (Prop.Property_Type));
      Val.Set_Field ("description", R.To_String (Prop.Property_Description));
      return val;
   end Property_JSON;

   function Schema_JSON (S : Schema.Vector) return GNATCOLL.JSON.JSON_Value is
      Val            : JSON.JSON_Value := JSON.Create_Object;
      Props          : JSON.Json_Value := JSON.Create_Object;
      Required_Array : JSON.JSON_Array;
   begin
      val.Set_Field ("type", "object");
      for Property of S loop
         Props.Set_Field
           (R.To_String (Property.Property_Name), Property_JSON (Property));
         if Property.Is_Required = true then
            declare
               Field_Val : JSON.JSON_Value :=
                 JSON.Create (R.To_String (Property.Property_Name));
            begin
              JSON.Append(Required_Array, Field_Val);
            end;
         end if;
      end loop;
      Val.Set_Field ("properties", Props);
      Val.Set_Field ("additionalProperties", false);
      Val.Set_Field ("required", Required_Array);
      return val;
   end Schema_JSON;

end Mcp_Tool;
