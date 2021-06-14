import {
	EventDispatcher,
	MOUSE,
} from './three.module.js';

import { TWEEN } from "./tween.module.min.js"
import { TrackballControls } from "./TrackballControls.js";
import { CSS3DRenderer, CSS3DObject } from "./CSS3DRenderer.js";

class TileEngine extends EventDispatcher {
	constructor( object, domElement ) {
	  
		this.initScene = function(){
			container = document.createElement( 'div' );
			document.body.appendChild( container );
			scene = new THREE.Scene();		
		}
	
	}	
}