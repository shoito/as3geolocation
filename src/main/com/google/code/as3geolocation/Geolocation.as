/*
   Copyright (c) 2010 shoito

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.
 */
package com.google.code.as3geolocation
{
    import flash.external.ExternalInterface;

    /**
	 * ActionScriptからGeolocation APIを簡単に利用できるラッパーユーティリティです.
	 * 
	 * <p>以下のインターフェース仕様に従ってラッパーを提供していますが, 一部独自に追加しているものがあります.</p>
	 * <p>Ref. Geolocation API - <a href="http://www.w3.org/TR/geolocation-API/">5.1 Geolocation interface</a></p>
	 * <pre>
     * interface Geolocation { 
     *   void getCurrentPosition(in PositionCallback successCallback, [Optional] in PositionErrorCallback errorCallback, [Optional] in PositionOptions options);
     *   
     *   long watchPosition(in PositionCallback successCallback, [Optional] in PositionErrorCallback errorCallback, [Optional] in PositionOptions options);
     *   
     *   void clearWatch(in int watchId);
     * };
     *
     * [Callback=FunctionOnly, NoInterfaceObject]
     * interface PositionCallback {
     *   void handleEvent(in Position position);
     * };
     *
     * [Callback=FunctionOnly, NoInterfaceObject]
     * interface PositionErrorCallback {
     *   void handleEvent(in PositionError error);
     * };
     *
     * [Callback, NoInterfaceObject]
     * interface PositionOptions {
     *   attribute boolean enableHighAccuracy;
     *   attribute long timeout;
     *   attribute long maximumAge;
     * };
     *
     * interface Position {
     *   readonly attribute Coordinates coords;
     *   readonly attribute DOMTimeStamp timestamp;
     * };
     *    
     * interface Coordinates {
     *   readonly attribute double latitude;
     *   readonly attribute double longitude;
     *   readonly attribute double altitude;
     *   readonly attribute double accuracy;
     *   readonly attribute double altitudeAccuracy;
     *   readonly attribute double heading;
     *   readonly attribute double speed;
     * };
     *
     * interface PositionError {
     *   const unsigned short UNKNOWN_ERROR = 0;
     *   const unsigned short PERMISSION_DENIED = 1;
     *   const unsigned short POSITION_UNAVAILABLE = 2;
     *   const unsigned short TIMEOUT = 3;
     *   readonly attribute unsigned short code;
     *   readonly attribute DOMString message;
     * };</pre>
     */
    public class Geolocation
    {
		/**
		 * 現在位置を取得します.
		 * 
		 * @param successCallback 現在位置を取得した際に呼ばれるコールバック関数
		 * @param errorCallback エラー発生時に呼ばれるコールバック関数
		 * @param options 最大試行回数、要求待ち時間など
		 */
        public static function getCurrentPosition(successCallback:Function, errorCallback:Function = null, options:* = null):void
        {
			
            ExternalInterface.call("as3geolocation.assignSwf", ExternalInterface.objectID);
            ExternalInterface.addCallback("successCallbackToAS", successCallback);
            ExternalInterface.addCallback("errorCallbackToAS", errorCallback);
        
            ExternalInterface.call("as3geolocation.getCurrentPosition", "successCallbackToAS", "errorCallbackToAS", options);
        }

		/**
		 * 現在位置を監視します.
		 * 
		 * @param successCallback 現在位置を取得した際に呼ばれるコールバック関数
		 * @param errorCallback エラー発生時に呼ばれるコールバック関数
		 * @param options 最大試行回数、要求待ち時間など
		 * @return watch id
		 */
        public static function watchPosition(successCallback:Function, errorCallback:Function = null, options:* = null):uint
        {
            ExternalInterface.call("as3geolocation.assignSwf", ExternalInterface.objectID);
            ExternalInterface.addCallback("successCallbackToAS", successCallback);
            ExternalInterface.addCallback("errorCallbackToAS", errorCallback);
            
            return ExternalInterface.call("navigator.geolocation.watchPosition", "successCallbackToAS", "errorCallbackToAS", options);
        }
        
		/**
		 * 現在位置の監視を解除します.
		 * 
		 * @param watchId watchPositionで返されたwatch id
		 */
        public static function clearWatch(watchId:int):void
        {
            ExternalInterface.call("navigator.geolocation.clearWatch", watchId);
        }
		
		/**
		 * as3geolocationが実行中のブラウザで機能するかどうか返します.
		 * 
		 * @return as3geolocationが機能する場合は<code>true</code>, 機能しない場合は<code>false</code>
		 */
		public static function available():Boolean
		{
			return ExternalInterface.available && ExternalInterface.call("function() { return typeof navigator.geolocation != 'undefined'; }");
		}
    }
}