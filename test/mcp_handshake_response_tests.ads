with AUnit.Test_Suites;
with AUnit.Test_Fixtures;

package Mcp_Handshake_Response_Tests is
   type Test_Fixture is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Test_Serializes_Handshake (Test : in out Test_Fixture);
   procedure Test_Omits_Disabled_Logging (Test : in out Test_Fixture);

   function Suite return AUnit.Test_Suites.Access_Test_Suite;
end Mcp_Handshake_Response_Tests;