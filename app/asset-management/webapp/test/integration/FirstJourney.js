sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheAssetsList.iSeeThisPage();
            Then.onTheAssetsList.onTable().iCheckColumns(4, {"name":{"header":"name"},"type":{"header":"type"},"status":{"header":"status"},"employee_ID":{"header":"employee_ID"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheAssetsList.onFilterBar().iExecuteSearch();
            
            Then.onTheAssetsList.onTable().iCheckRows();

            When.onTheAssetsList.onTable().iPressRow(0);
            Then.onTheAssetsObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});