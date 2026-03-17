sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmanagement/test/integration/pages/AssetsList",
	"assetmanagement/test/integration/pages/AssetsObjectPage"
], function (JourneyRunner, AssetsList, AssetsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmanagement') + '/test/flp.html#app-preview',
        pages: {
			onTheAssetsList: AssetsList,
			onTheAssetsObjectPage: AssetsObjectPage
        },
        async: true
    });

    return runner;
});

