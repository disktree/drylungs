package drylungs;

import three.core.InstancedBufferGeometry;
import three.geometries.CircleBufferGeometry;
import three.objects.LineSegments;
import three.materials.LineBasicMaterial;
import three.materials.PointsMaterial;
import three.objects.Points;
import three.core.InstancedBufferAttribute;
import three.core.BufferAttribute;
import three.math.Vector3;
import haxe.ds.Vector;
import three.core.BufferGeometry;
import js.lib.Float32Array;
import three.core.BufferAttribute.Float32BufferAttribute;
import om.IntTools;
import three.scenes.Fog;
import js.html.audio.AnalyserNode;
import js.html.audio.AudioContext;
import js.lib.Uint8Array;
import js.Browser.document;
import js.Browser.window;
import three.geometries.PlaneBufferGeometry;
import three.materials.MeshLambertMaterial;
import three.objects.Group;
import three.lights.SpotLight;
import three.scenes.FogExp2;
import js.html.CanvasElement;
import om.three.control.OrbitControls;
import three.Lib;
import three.cameras.PerspectiveCamera;
import three.geometries.BoxGeometry;
import three.helpers.*;
import three.lights.PointLight;
import three.materials.RawShaderMaterial;
import three.materials.MeshBasicMaterial;
import three.materials.MeshPhongMaterial;
import three.math.Color;
import three.loaders.TextureLoader;
import three.objects.Mesh;
import three.renderers.WebGLRenderer;
import three.scenes.Scene;
import om.three.material.*;
import om.three.render.*;

@:keep
class Intro {
	
	public var canvas(default,null) : CanvasElement;
	
	var renderer : WebGLRenderer;
	var composer : EffectComposer;
	var filmPass : FilmPass;

	var scene : Scene;
	var camera : PerspectiveCamera;
	var mesh : Mesh;
	var lungs : Group;
	var controls : OrbitControls;

	var analyser : AnalyserNode;
	var timeData : Uint8Array;

	public function new( color : Int ) {

		canvas = cast document.querySelector( 'canvas.intro' );

		renderer = new WebGLRenderer( { canvas: canvas, antialias: false, alpha: true } );
		renderer.setSize( window.innerWidth, window.innerHeight );
		renderer.setPixelRatio( window.devicePixelRatio );
		//renderer.shadowMap.enabled = true;
		//renderer.shadowMap.type = PCFSoftShadowMap;

		scene = new Scene();
		//scene.fog = new FogExp2( color, 0.5 );
		scene.fog = new FogExp2( 0xefd1b5, 0.0025 );

		camera = new PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 0.00001, 100000 );
		camera.position.set( 0, 10, 10 );
		camera.lookAt( scene.position );
		scene.add( camera );

		//composer = new EffectComposer( renderer );
		//composer.addPass( new RenderPass( scene, camera ) );

		//var dithering = new DitheringPass();
		//composer.addPass( dithering );
		
		//var dotScreen = new DotScreenPass();
		//dotScreen.scale = 4;
		//composer.addPass( dotScreen );
		
		//composer.addPass( new HueSaturationPass(0.324,0) );
		//composer.addPass( new C64Pass() );
		
		//var bc = new BrightnessContrastPass(0,0.5);
		//bc.contrast = 0.666;
		//composer.addPass( bc );
		
		//composer.addPass( new TiltShiftHorizontalPass(0.01) );
		//composer.addPass( new TiltShiftVerticalPass(0.01) );
		//composer.addPass( new SSAOPass() );
		//composer.addPass( new KaleidoPass(2) );

		// filmPass = new FilmPass();
		// filmPass.nIntensity = 24.8;
		// composer.addPass( filmPass );
		
		var light = new PointLight( 0xddffdd, 0.8 );
		light.position.z = 70;
		light.position.y = - 70;
		light.position.x = - 70;
		scene.add( light );
		
		var light2 = new PointLight( 0xffdddd, 0.8 );
		light2.position.z = 70;
		light2.position.x = - 70;
		light2.position.y = 70;
		scene.add( light2 );
		
		var light3 = new PointLight( 0xddddff, 0.8 );
		light3.position.z = 70;
		light3.position.x = 70;
		light3.position.y = - 70;
		scene.add( light3 );
		
		var spotLight = new SpotLight( color, 5 );
		spotLight.position.set(1,5,5);
		spotLight.angle = Math.PI / 4;
		spotLight.distance = 15;
		spotLight.castShadow = true;
		spotLight.shadow.mapSize.width = 2048;
		spotLight.shadow.mapSize.height = 2048;
		scene.add(spotLight);
		//scene.add(new SpotLightHelper(spotLight));
		
		//scene.add(new AxesHelper(10));

		/* var light1 = new PointLight( 0xffffff, 2 );
		light1.position.set( 100, 30, 100 );
		scene.add( light1 );
		//scene.add( new PointLightHelper( light1, 10 ) );
 */
		controls = new OrbitControls( camera, canvas );
		//controls.enabled = false;
		controls.screenSpacePanning = true;


		/* var geometry = new BoxGeometry( 1, 1, 1, 1, 1, 1 );
			var materials = [
				new MeshPhongMaterial( { color: new Color(0x000000), shininess: 100 } ),
			 	new MeshBasicMaterial( { color: new Color(0xffffff), wireframe: true } )
			];

			var mesh = new Group();
			for( m in materials ) mesh.add( new Mesh( geometry, m ) );
			scene.add( mesh ); */


		//update(om.Time.now());
		
		/*
		lungs = new Group();
		scene.add( lungs );
		
		
		//var diffuseColor = new Color().setHSL( alpha, 0.5, gamma * 0.5 + 0.1 ).multiplyScalar( 1 - beta * 0.2 );
		var textureLoader = new TextureLoader();
		textureLoader.load('img/cover/512/DLR001.jpg', function(tx){
			trace(tx);
			//var box = new Mesh(new BoxGeometry(1, 1, 1), new MeshBasicMaterial({map:tx}) );
			//scene.add(box);
			
			var material = new MeshPhongMaterial({  map: tx });
			var loader = new om.three.loader.GLTFLoader();
			loader.load( 'msh/astronaut.glb', gltf -> {
				trace(gltf);
				for( child in gltf.scene.children ) {
					var mesh : Mesh = cast child;
					mesh.material = material;
					//mesh.castShadow = true;
					//mesh.receiveShadow = true;
					lungs.add( mesh );
				}
			} );
		});
		*/

		var loader = new om.three.loader.GLTFLoader();
		loader.load( 'msh/lung_smoke_2.gltf.glb', gltf -> {
			trace(gltf);
			var lung = gltf.scene.children[0];
			lung.updateMatrixWorld( true );
			scene.add( lung );
		});


		/*
		
		// https://github.com/mrdoob/three.js/blob/master/examples/webgl_buffergeometry_drawrange.html

		var group = new Group();
		scene.add( group );

		var r = 800;
		var rHalf = r / 2;
		var maxParticleCount = 1000;
		var particleCount = 500;
		var segments = maxParticleCount * maxParticleCount;
		var positions = new Float32Array( segments * 3 );
		var colors = new Float32Array( segments * 3 );
		var particles = new BufferGeometry();
		var particlePositions = new Float32Array( maxParticleCount * 3 );
		var particlesData = [];
		for( i in 0...maxParticleCount ) {
			var x = Math.random() * r - r / 2;
			var y = Math.random() * r - r / 2;
			var z = Math.random() * r - r / 2;
			particlePositions[ i * 3 ] = x;
			particlePositions[ i * 3 + 1 ] = y;
			particlePositions[ i * 3 + 2 ] = z;
			particlesData.push( {
				velocity: new Vector3( - 1 + Math.random() * 2, - 1 + Math.random() * 2, - 1 + Math.random() * 2 ),
				numConnections: 0
			} );
		}
		particles.setDrawRange( 0, particleCount );
		particles.setAttribute( 'position', untyped new BufferAttribute( particlePositions, 3 ).setUsage( DynamicDrawUsage ) );
		// create the particle system

		var pMaterial = new PointsMaterial( {
			color: 0xFFFFFF,
			size: 3,
			blending: AdditiveBlending,
			transparent: true,
			sizeAttenuation: false
		} );

		var pointCloud = new Points( particles, pMaterial );
		group.add( pointCloud );
		
		var geometry = new BufferGeometry();
		geometry.setAttribute( 'position', untyped new BufferAttribute( positions, 3 ).setUsage( DynamicDrawUsage ) );
		geometry.setAttribute( 'color', untyped new BufferAttribute( colors, 3 ).setUsage( DynamicDrawUsage ) );
		geometry.computeBoundingSphere();
		geometry.setDrawRange( 0, 0 ); 

		var material = new LineBasicMaterial( {
			vertexColors: VertexColors,
			blending: AdditiveBlending,
			transparent: true
		} );
		var linesMesh = new LineSegments( geometry, material );
		group.add( linesMesh );
		*/
		
		/*
		var audioElement = document.createAudioElement();
		//audioElement.autoplay = true;
		//audioElement.preload = "metadata";
		audioElement.preload = "none";
		audioElement.crossOrigin = "anonymous";
		audioElement.controls = false;
		//audioElement.muted = true;
		audioElement.play();

		var sourceElement = document.createSourceElement();
		sourceElement.type = 'application/ogg';
		sourceElement.src = 'audio/DLR001/A_Untitled.mp3';
		audioElement.appendChild( sourceElement );

		audioElement.onplaying = function() {
			var audio = new AudioContext();
			analyser = audio.createAnalyser();
			//analyser.fftSize = 2048;
			analyser.fftSize = 2048;
			//analyser.smoothingTimeConstant = 0.8;
			//analyser.minDecibels = -140;
			//analyser.maxDecibels = 0;
			analyser.connect( audio.destination );
			//freqData = new Uint8Array( analyser.frequencyBinCount );
			timeData = new Uint8Array( analyser.frequencyBinCount );
			var source = audio.createMediaElementSource( audioElement );
			source.connect( analyser );

			window.requestAnimationFrame( update );
		}
		*/

		window.requestAnimationFrame( update );

		window.addEventListener( 'resize', handleWindowResize, false );
	}

	function update( time : Float ) {

		window.requestAnimationFrame( update );

		/*
		var m : Mesh = cast lungs.children[0];
		trace(untyped m.geometry.vertices);
		var positions = new Float32Array(300);
		for( i in 0...100 ) {
			for( j in 0...3 ) positions[i*j] = (Math.random()*i);
		}
		new Float32BufferAttribute(positions,3) ;
		//m.geometry.setAttribute('position', new Float32BufferAttribute(positions,3) );
		//m.geometry;
		*/
		
		/*
		if( timeData != null ) {

			analyser.getByteTimeDomainData( timeData );
			
			lungs.scale.set(
				timeData[0] / 100,
				timeData[512] / 100,
				timeData[1023] / 100
			); //0.01;
				
			lungs.rotation.x = timeData[0] / 100; //0.01;
			lungs.rotation.y = timeData[512] / 100;
			lungs.rotation.z = timeData[1023] / 100;
		}
		
		lungs.rotation.x += 0.001;
		lungs.rotation.y += 0.002;
		lungs.rotation.z += 0.003;
		*/

		//controls.update();
		

		//filmPass.time = time * 0.001;

		//composer.render();
		renderer.render( scene, camera );
	}

	function handleWindowResize(e) {
		var w = window.innerWidth;
		var h = window.innerHeight;
		camera.aspect = w / h;
		camera.updateProjectionMatrix();
		renderer.setSize( w, h );
	}

	static function main() {

		window.addEventListener( 'load', e -> {

			haxe.Timer.delay( function(){

				var style = window.getComputedStyle(document.documentElement);
				var f_med = '0x'+style.getPropertyValue('--f_med').trim().substr(1).toUpperCase();
				trace(f_med);

				var color = IntTools.parse( f_med );
				var ani = new Intro( color );
				//ani.start();

			}, 200);
		});

	}
}
