// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "cxxmonero",
	platforms:[
		.macOS(.v13)
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "cxxmonero",
			targets: ["cxxepee"]),
	],
	dependencies:[
		.package(url:"https://github.com/tannerdsilva/cxxboost.git", .upToNextMinor(from:"1.82.0")),
		.package(name:"cxxrandomx", path:"../cxxrandomx")
	],
	targets: [
		.target(
			name:"cxxmonero_common",
			dependencies:[
				"cxxeasylogging++",
			]
		),
		.target(
			name:"cxxmonero_hardforks",
			path:"monero/src/hardforks",
			exclude:["CMakeLists.txt"],
			publicHeadersPath:"./"
		),
		.target(
			name:"cxxmonero_mnemonics",
			dependencies:[
				"cxxepee"
			],
			exclude:["include/mnemonics/CMakeLists.txt"]
		),
		.target(
			name:"cxxmonero_crypto",
			dependencies:[
				.product(name:"cxxrandomx", package:"cxxrandomx"),
				"cxxepee",
				"cxxmonero_common"
			],
			exclude:[
				"include/crypto/wallet/CMakeLists.txt",
				"include/crypto/wallet/empty.h.in"
			]
		),
		.target(
			name:"cxxrapidjson",
			exclude:[
				".cant-see-me"
			]
		),
		.target(
			name:"cxxqrcodegen",
			path:"monero/external/qrcodegen",
			exclude:["./CMakeLists.txt"],
			sources:["./"],
			publicHeadersPath:"./"
		),
		.target(
			name:"cxxeasylogging++",
			path:"monero/external/easylogging++",
			exclude:["./CMakeLists.txt"],
			sources:["./easylogging++.cc"],
			publicHeadersPath:".",
			packageAccess:true),
		.target(
			name:"cxxepee",
			dependencies:[
				"cxxeasylogging++",
				"libopenssl",
				"libreadline",
				.product(name:"cxxboost_filesystem", package:"cxxboost"),
				.product(name:"cxxboost_thread", package:"cxxboost"),
				.product(name:"cxxboost_variant", package:"cxxboost"),
				.product(name:"cxxboost_circular_buffer", package:"cxxboost"),
				.product(name:"cxxboost_asio", package:"cxxboost"),
				.product(name:"cxxboost_uuid", package:"cxxboost"),
				.product(name:"cxxboost_lambda", package:"cxxboost"),
				.product(name:"cxxboost_foreach", package:"cxxboost"),
				.product(name:"cxxboost_multiprecision", package:"cxxboost"),
				.product(name:"cxxboost_spirit", package:"cxxboost"),
			],
			path:"monero/contrib/epee",
			exclude:[
				"./src/CMakeLists.txt"
			],
			sources:["src"],
			publicHeadersPath:"include",
			packageAccess:true
		),
		.systemLibrary(
			name:"libopenssl",
			pkgConfig:"openssl",
			providers: [
				.brew(["openssl"]),
				.apt(["libssl-dev"])
			]
		),
		.systemLibrary(
			name:"libreadline",
			pkgConfig:"readline",
			providers:[
				.brew(["readline"]),
				.apt(["libreadline-dev"])
			]
		),
		.systemLibrary(
			name:"libunbound",
			pkgConfig:"libunbound",
			providers:[
				.apt(["libunbound-dev"]),
				.brew(["unbound"])
			]
		),
		.systemLibrary(
			name:"libsodium",
			pkgConfig:"libsodium",
			providers: [
                .brew(["libsodium"]), 
                .apt(["libsodium-dev"])
            ]
		),
		.target(
			name:"cxxboost_portable_binary_archives",
			dependencies:[
				.product(name:"cxxboost_predef", package:"cxxboost"),
				.product(name:"cxxboost_serialization", package:"cxxboost")
			]
		)
	],
    cxxLanguageStandard:.cxx14
)
