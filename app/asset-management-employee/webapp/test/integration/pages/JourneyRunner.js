sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmanagementemployee/test/integration/pages/EmployeeList",
	"assetmanagementemployee/test/integration/pages/EmployeeObjectPage",
	"assetmanagementemployee/test/integration/pages/AssetObjectPage"
], function (JourneyRunner, EmployeeList, EmployeeObjectPage, AssetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmanagementemployee') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeeList: EmployeeList,
			onTheEmployeeObjectPage: EmployeeObjectPage,
			onTheAssetObjectPage: AssetObjectPage
        },
        async: true
    });

    return runner;
});

