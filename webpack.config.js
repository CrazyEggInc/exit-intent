const webpack = require('webpack');
const path = require('path');

/*
 * We've enabled UglifyJSPlugin for you! This minifies your app
 * in order to load faster and run less javascript.
 *
 * https://github.com/webpack-contrib/uglifyjs-webpack-plugin
 *
 */

const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

module.exports = {
	entry: './src/exit-intent.js',

	output: {
		filename: 'exit-intent.js',
		path: path.resolve(__dirname, 'dist'),
		library: "ExitIntent",
		libraryExport: "default"
	},

	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: /node_modules/,
				loader: 'babel-loader',

				options: {
					presets: ['es2015']
				}
			},
			{
				test: /\.elm$/,
				exclude: [/elm-stuff/, /node_modules/],
				use: {
					loader: 'elm-webpack-loader',
					options: {}
				}
			}
		]
	},

	plugins: [new UglifyJSPlugin()]
};
