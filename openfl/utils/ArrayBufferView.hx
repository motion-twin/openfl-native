package openfl.utils;


import flash.utils.ByteArray;

#if cpp
import haxe.io.BytesData;
#end


class ArrayBufferView implements IMemoryRange {
	
	
	public var buffer (default, null):ByteArray;
	public var byteOffset (default, null):Int;
	public var byteLength (default, null):Int;
	
	private static var invalidDataIndex = "Invalid data index";
	#if cpp
	private var bytes:BytesData;
	#end
	
	
	private inline function new (lengthOrBuffer:Dynamic, byteOffset:Int = 0, length:Null<Int> = null) {
		
		if (Std.is (lengthOrBuffer, Int)) {
			
			byteLength = Std.int (lengthOrBuffer);
			this.byteOffset = 0;
			buffer = new ArrayBuffer (Std.int (lengthOrBuffer));
			
		} else {
			buffer = lengthOrBuffer;
			
			if (buffer == null) {
				
				throw ("Invalid input buffer");
				
			}
			
			this.byteOffset = byteOffset;
			
			if (byteOffset > buffer.length) {
				
				throw ("Invalid starting position");
				
			}
			
			if (length == null) {
				
				byteLength = buffer.length - byteOffset;
				
			} else {
				
				byteLength = length;
				
				if (byteLength + byteOffset > buffer.length) {
					
					throw ("Invalid buffer length " +(byteLength + byteOffset)+ "<>"+buffer.length);
					
				}
				
			}
			
		}
		
		buffer.bigEndian = false;
		
		#if cpp
		bytes = buffer.getData ();
		#end
		
	}
	
	
	public inline function getByteBuffer ():ByteArray {
		
		return buffer;
		
	}
	
	
	inline public function getFloat32 (position:Int):Float {
		#if cpp
		untyped return __global__.__hxcpp_memory_get_float (bytes, position + byteOffset);
		#else
		buffer.position = position + byteOffset;
		return buffer.readFloat ();
		#end
	}
	
	#if (cpp&&(hxcpp_api_level >= 312))
	inline public function getFloat32f (position:Int): cpp.Float32 {
		untyped return __global__.__hxcpp_memory_get_f32(bytes, position + byteOffset);
	}
	#end
	
	
	inline public function getInt16 (position:Int):Int {
		
		#if cpp
		untyped return __global__.__hxcpp_memory_get_i16 (bytes, position + byteOffset);
		#else
		buffer.position = position + byteOffset;
		return buffer.readShort ();
		#end
		
	}
	
	
	inline public function getInt32 (position:Int):Int {
		
		#if cpp
		untyped return __global__.__hxcpp_memory_get_i32 (bytes, position + byteOffset);
		#else
		buffer.position = position + byteOffset;
		return buffer.readInt ();
		#end
		
	}
	
	
	public function getLength ():Int {
		
		return byteLength;
		
	}
	
	
	public function getNativePointer ():Dynamic {
		
		return buffer.getNativePointer ();
		
	}
	
	
	public function getStart ():Int {
		
		return byteOffset;
		
	}
	
	
	inline public function getUInt8 (position:Int):Int {
		
		#if cpp
		untyped return __global__.__hxcpp_memory_get_byte (bytes, position + byteOffset);
		#else
		buffer.position = position + byteOffset;
		return buffer.readByte ();
		#end
		
	}
	
	
	inline public function setFloat32 (position:Int, value:Float):Void {
		
		#if cpp
		untyped __global__.__hxcpp_memory_set_float (bytes, position + byteOffset, value);
		#else
		buffer.position = position + byteOffset;
		buffer.writeFloat (value);
		#end
		
	}
	
	#if( cpp && (hxcpp_api_level >= 312) )
	inline public function setFloat32f(position:Int, value:cpp.Float32): Void {
		untyped __global__.__hxcpp_memory_set_f32(bytes, position + byteOffset, value);
	}
	#end
	
	
	inline public function setInt16 (position:Int, value:Int):Void {
		
		#if cpp
		untyped __global__.__hxcpp_memory_set_i16 (bytes, position + byteOffset, value);
		#else
		buffer.position = position + byteOffset;
		buffer.writeShort (Std.int (value));
		#end
		
	}
	
	
	inline public function setInt32 (position:Int, value:Int):Void {
		
		#if cpp
		untyped __global__.__hxcpp_memory_set_i32 (bytes, position + byteOffset, value);
		#else
		buffer.position = position + byteOffset;
		buffer.writeInt (Std.int (value));
		#end
		
	}
	
	
	inline public function setUInt8 (position:Int, value:Int):Void {
		
		#if cpp
		untyped __global__.__hxcpp_memory_set_byte (bytes, position + byteOffset, value);
		#else
		buffer.position = position + byteOffset;
		buffer.writeByte (value);
		#end
		
	}
	
	
}