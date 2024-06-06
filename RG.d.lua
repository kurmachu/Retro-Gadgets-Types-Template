-- I don't know how these files work. I can't find anything concrete online.
-- See https://gist.github.com/Dekkonot/1f678708a3a36866d3c728b8cfb9589e for the best I could find.
-- v1.0.0 [Questions? @Kurmachu]

--Define your gadget's modules here:
declare gdt: {
	ROM: ROM,

	CPU0: CPU,

	-- Led0: Led,
	-- LedButton0: LedButton,
	-- LedButton1: LedButton,
	-- etc

	-- VideoChip0: VideoChip,
}


-------------------------------------------------------------------

-- #region comments have stopped working, so uhh no folding for you.


----------------- TYPES -----------------

--Color
declare class color end
declare function Color(r: number, g: number, b: number): color
declare function ColorRGBA(r: number, g: number, b: number, a: number): color
declare function ColorHSV(h: number, s: number, v: number): color
declare color: {
	black: color,
	blue: color,
	clear: color,
	cyan: color,
	gray: color,
	green: color,
	magenta: color,
	red: color,
	white: color,
	yellow: color,
}

--Vectors
declare class vec2 
	X: number
	Y: number
	__add: (vec2, vec2) -> vec2
	__sub: (vec2, vec2) -> vec2
	__mul: (vec2, number | vec2) -> vec2
end
declare function vec2(x: number, y:number): vec2
declare class vec3
	X: number
	Y: number
	Z: number
	--Unsure what vec3 can be used with
	__add: (vec3, vec3) -> vec3
	__sub: (vec3, vec3) -> vec3
	__mul: (vec3, number | vec3) -> vec3
end
declare function vec3(x: number, y:number, z:number): vec3

--InputSource
declare class InputSource end

--PixelData
declare class PixelData
	GetPixel: (self: PixelData, x: number, y: number) -> color
	SetPixel: (self: PixelData, x: number, y: number, color: color) -> ()
	Width: number
	Height: number
end
declare PixelData: {
	new: (width: number, height: number, color: color) -> PixelData
}

--RenderBuffer
declare class RenderBuffer 
	Name: string
	Type: "RenderBuffer"
	Width: number
	Height: number
	IsValid: (self: RenderBuffer) -> boolean
	GetPixelData: (self: RenderBuffer) -> PixelData
end

--Assets!
declare class Asset end
declare class Palette end
declare class SpriteSheet extends Asset
	Name: string
	Type: "SpriteSheet"
	Palette: Palette
	IsValid: (self: SpriteSheet) -> boolean
	GetPixelData: (self: SpriteSheet) -> PixelData
	GetSpritePixelData: (self: SpriteSheet, spriteX: number, spriteY: number) -> PixelData
end
declare class Code extends Asset end
declare class AudioSample extends Asset
	Name: string
	Type: "AudioSample"
	SamplesCount: number
	Channels: number
	Frequency: number
	Length: number
	Metadata: {
		LongDescription: any,
		Date: any,
		Year: any,
		TrackNumber: any,
		TrackTotal: any,
		DiscNumber: any,
		DiscTotal: any,
		Popularity: any,
		SeriesPart: any,
		Bitrate: any,
		BitDepth: any,
		SampleRate: any,
		IsVariableBitRate: any,
		Duration: any,
		SeriesTitle: any,
		SortTitle: any,
		Title: any,
		Artist: any,
		Composer: any,
		Comment: any,
		Genre: any,
		Album: any,
		Group: any,
		OriginalArtist: any,
		Copyright: any,
		OriginalAlbum: any,
		Publisher: any,
		PublishingDate: any,
		AlbumArtist: any,
		Conductor: any,
		ProductId: any,
		SortAlbum: any,
		SortAlbumArtist: any,
		SortArtist: any,
		Description: any
	}
	IsValid: (self: AudioSample) -> boolean
end

-----------------------------------------

declare class Motherboard end --Self-reports as a table. Contents unknown.
declare class Module 
	Motherboard: Motherboard
	Type: string
end

----------------- INPUT -----------------

--AnalogStick
declare class AnalogStick extends Module
	X: number
	Y: number
	InputSourceX: InputSource
	InputSourceY: InputSource
end
export type StickValueChangeEvent = {X: number, Y: number, Type: "StickValueChangeEvent"}

--DPad
declare class DPad extends Module
	X: number
	Y: number
	InputSourceX: InputSource
	InputSourceY: InputSource
end
export type DPadValueChangeEvent = {X: number, Y: number, Type: "DPadValueChangeEvent"}

--Keypad
declare class Keypad extends Module
	ButtonsState: {{boolean}}
	ButtonsDown: {{boolean}}
	ButtonsUp: {{boolean}}
	ButtonsInputSource: {{InputSource}}
end
export type KeypadButtonEvent = {X: number, Y: number, ButtonDown: boolean, ButtonUp: boolean, Type: "KeypadButtonEvent"}

--Knob
declare class Knob extends Module
	Value: number
	DeltaValue: number
	IsMoving: boolean
end
export type KnobValueChangeEvent = {Value: number, DeltaValue: number, Type: "KnobValueChangeEvent"}

--LedButton
declare class LedButton extends Module
	ButtonState: boolean
	ButtonDown: boolean
	ButtonUp: boolean
	InputSource: InputSource
	LedState: boolean
	LedColor: color
end
export type LedButtonEvent = {ButtonDown: boolean, ButtonUp: boolean, Type: "LedButtonEvent"}

--ScreenButton
declare class ScreenButton extends Module
	ButtonState: boolean
	ButtonDown: boolean
	ButtonUp: boolean
	InputSource: InputSource
	VideoChip: VideoChip
	Offset: vec2
	Width: number
	Height: number
end
export type ScreenButtonEvent = {ButtonDown: boolean, ButtonUp: boolean, Type: "ScreenButtonEvent"}

--Slider
declare class Slider extends Module
	Value: number
	IsMoving: boolean
end
export type SliderValueChangeEvent = {Value: number, Type: "SliderValueChangeEvent"}

--Switch
declare class Switch extends Module
	State: boolean
	InputSource: InputSource
end
export type SwitchStateChangeEvent = {State: boolean, Type: "SwitchStateChangeEvent"}

--Webcam
declare class Webcam extends Module
	RenderTarget: VideoChip
	AccessDenied: boolean
	IsActive: boolean
	IsAvailable: boolean
	GetRenderBuffer: (self: Webcam) -> RenderBuffer
end
export type WebcamIsActiveEvent = {IsActive: boolean, IsAvailable: boolean, AccessDenied: boolean, Type: "WebcamIsActiveEvent"}

-----------------------------------------

----------------- OUTPUT -----------------

--AnalogGauge
declare class AnalogGauge extends Module
	Value: number
end

--LcdDisplay
declare class LcdDisplay extends Module
	Text: string
	BgColor: color
	TextColor: color
end

--Led
declare class Led extends Module
	State: boolean
	Color: color
end

--LedMatrix
declare class LedMatrix extends Module
	States: {{boolean}}
	Colors: {{color}}
end

--LedStrip
declare class LedStrip extends Module
	States: {boolean}
	Colors: {color}
end

--Screen
declare class Screen extends Module
	VideoChip: VideoChip
	Offset: vec2
	Width: number
	Height: number
end

--SegmentDisplay
declare class SegmentDisplay extends Module
	States: {{boolean}}
	Colors: {{color}}
	ShowDigit: (self: SegmentDisplay, groupIndex: number, digit: number) -> ()
	SetDigitColor: (self: SegmentDisplay, groupIndex: number, color: color) -> ()
end

--Speaker
declare class Speaker extends Module
	State: boolean
end

------------------------------------------

----------------- MISC -----------------

--AudioChip
declare class AudioChip extends Module
	ChannelsCount: number
	Volume: number

	GetSpectrumData: (self: AudioChip, channel: number, samplesCount: number) -> {number}
	GetDspTime: (self: AudioChip) -> number
	Play: (self: AudioChip, audioSample: AudioSample, channel: number) -> ()
	PlayScheduled: (self: AudioChip, audioSample: AudioSample, channel: number, dspTime: number) -> ()
	PlayLoop: (self: AudioChip, audioSample: AudioSample, channel: number) -> ()
	PlayLoopScheduled: (self: AudioChip, audioSample: AudioSample, channel: number, dspTime: number) -> ()
	Stop: (self: AudioChip, channel: number) -> ()
	Pause: (self: AudioChip, channel: number) -> ()
	UnPause: (self: AudioChip, channel: number) -> ()
	IsPlaying: (self: AudioChip, channel: number) -> boolean
	IsPaused: (self: AudioChip, channel: number) -> boolean
	GetPlayTime: (self: AudioChip, channel: number) -> number
	SeekPlayTime: (self: AudioChip, time: number, channel: number) -> ()
	SetChannelVolume: (self: AudioChip, volume: number, channel: number) -> ()
	GetChannelVolume: (self: AudioChip, channel: number) -> number
	SetChannelPitch: (self: AudioChip, pitch: number, channel: number) -> ()
	GetChannelPitch: (self: AudioChip, channel: number) -> number
end
export type AudioChipChannelEvent = {Channel: number, Type: "AudioChipChannelEvent"}

--CPU
declare class CPU extends Module
	Source: Code
	Time: number
	DeltaTime: number
	EventChannels: {Module}
end

--Decoration 
declare class Decoration extends Module
end

--FlashMemory
declare class FlashMemory extends Module
	Size: number
	Usage: number
	Save: (self: FlashMemory, table: {[any]: any}) -> boolean
	Load: (self: FlashMemory) -> {[any]: any}
end

--GamepadChip
declare class GamepadChip extends Module
	GamepadIndex: number
	IsActive: boolean

	GetButton: (self: GamepadChip, name: ButtonInputName) -> InputSource
	GetAxis: (self: GamepadChip, name: AxisInputName) -> InputSource
	GetButtonAxis: (self: GamepadChip, negativeName: ButtonInputName, positiveName: ButtonInputName) -> InputSource
end
declare GamepadChip: {
	LeftStickX: AxisInputName,
	LeftStickY: AxisInputName,
	RightStickX: AxisInputName,
	RightStickY: AxisInputName,

	ActionBottomRow1: ButtonInputName,
	ActionBottomRow2: ButtonInputName,
	ActionBottomRow3: ButtonInputName,
	ActionTopRow1: ButtonInputName,
	ActionTopRow2: ButtonInputName,
	ActionTopRow3: ButtonInputName,
	LeftShoulder1: ButtonInputName,
	LeftShoulder2: ButtonInputName,
	RightShoulder1: ButtonInputName,
	RightShoulder2: ButtonInputName,
	Center1: ButtonInputName,
	Center2: ButtonInputName,
	Center3: ButtonInputName,
	LeftStickButton: ButtonInputName,
	RightStickButton: ButtonInputName,
	DPadUp: ButtonInputName,
	DPadRight: ButtonInputName,
	DPadDown: ButtonInputName,
	DPadLeft: ButtonInputName
}
export type GamepadChipIsActiveEvent = {IsActive: boolean, Type: "GamepadChipIsActiveEvent"}
export type GamepadChipButtonEvent = {ButtonDown: boolean, ButtonUp: boolean, IsAxis: true, InputName: AxisInputName, Type: "GamepadChipButtonEvent"} | {ButtonDown: boolean, ButtonUp: boolean, IsAxis: false, InputName: ButtonInputName, Type: "GamepadChipButtonEvent"}
export type GamepadChipEvent = GamepadChipIsActiveEvent | GamepadChipButtonEvent
declare class InputName end
declare class ButtonInputName extends InputName end
declare class AxisInputName extends InputName end

--KeyboardChip
declare class KeyboardChip extends Module
	GetButton: (self: KeyboardChip, name: KeyInputName) -> InputSource
	GetButtonAxis: (self: KeyboardChip, negativeName: KeyInputName, positiveName: KeyInputName) -> InputSource
end
declare KeyboardChip: {
	Return: KeyInputName,
	Space: KeyInputName,
	LeftArrow: KeyInputName,
	RightArrow: KeyInputName,
	DownArrow: KeyInputName,
	UpArrow: KeyInputName,
	Backspace: KeyInputName,
	Escape: KeyInputName,
	Tab: KeyInputName,
	Clear: KeyInputName,
	Pause: KeyInputName,
	Exclaim: KeyInputName,
	DoubleQuote: KeyInputName,
	Hash: KeyInputName,
	Dollar: KeyInputName,
	Percent: KeyInputName,
	Ampersand: KeyInputName,
	Quote: KeyInputName,
	LeftParen: KeyInputName,
	RightParen: KeyInputName,
	Asterisk: KeyInputName,
	Plus: KeyInputName,
	Comma: KeyInputName,
	Minus: KeyInputName,
	Period: KeyInputName,
	Slash: KeyInputName,
	Alpha0: KeyInputName,
	Alpha1: KeyInputName,
	Alpha2: KeyInputName,
	Alpha3: KeyInputName,
	Alpha4: KeyInputName,
	Alpha5: KeyInputName,
	Alpha6: KeyInputName,
	Alpha7: KeyInputName,
	Alpha8: KeyInputName,
	Alpha9: KeyInputName,
	Colon: KeyInputName,
	Semicolon: KeyInputName,
	Less: KeyInputName,
	Equals: KeyInputName,
	Greater: KeyInputName,
	Question: KeyInputName,
	At: KeyInputName,
	LeftBracket: KeyInputName,
	Backslash: KeyInputName,
	RightBracket: KeyInputName,
	Caret: KeyInputName,
	Underscore: KeyInputName,
	BackQuote: KeyInputName,
	A: KeyInputName,
	B: KeyInputName,
	C: KeyInputName,
	D: KeyInputName,
	E: KeyInputName,
	F: KeyInputName,
	G: KeyInputName,
	H: KeyInputName,
	I: KeyInputName,
	J: KeyInputName,
	K: KeyInputName,
	L: KeyInputName,
	M: KeyInputName,
	N: KeyInputName,
	O: KeyInputName,
	P: KeyInputName,
	Q: KeyInputName,
	R: KeyInputName,
	S: KeyInputName,
	T: KeyInputName,
	U: KeyInputName,
	V: KeyInputName,
	W: KeyInputName,
	X: KeyInputName,
	Y: KeyInputName,
	Z: KeyInputName,
	LeftCurlyBracket: KeyInputName,
	Pipe: KeyInputName,
	RightCurlyBracket: KeyInputName,
	Tilde: KeyInputName,
	Delete: KeyInputName,
	Keypad0: KeyInputName,
	Keypad1: KeyInputName,
	Keypad2: KeyInputName,
	Keypad3: KeyInputName,
	Keypad4: KeyInputName,
	Keypad5: KeyInputName,
	Keypad6: KeyInputName,
	Keypad7: KeyInputName,
	Keypad8: KeyInputName,
	Keypad9: KeyInputName,
	KeypadPeriod: KeyInputName,
	KeypadDivide: KeyInputName,
	KeypadMultiply: KeyInputName,
	KeypadMinus: KeyInputName,
	KeypadPlus: KeyInputName,
	KeypadEnter: KeyInputName,
	KeypadEquals: KeyInputName,
	Insert: KeyInputName,
	Home: KeyInputName,
	End: KeyInputName,
	PageUp: KeyInputName,
	PageDown: KeyInputName,
	F1: KeyInputName,
	F2: KeyInputName,
	F3: KeyInputName,
	F4: KeyInputName,
	F5: KeyInputName,
	F6: KeyInputName,
	F7: KeyInputName,
	F8: KeyInputName,
	F9: KeyInputName,
	F10: KeyInputName,
	F11: KeyInputName,
	F12: KeyInputName,
	F13: KeyInputName,
	F14: KeyInputName,
	F15: KeyInputName,
	Numlock: KeyInputName,
	CapsLock: KeyInputName,
	ScrollLock: KeyInputName,
	RightShift: KeyInputName,
	LeftShift: KeyInputName,
	RightControl: KeyInputName,
	LeftControl: KeyInputName,
	RightAlt: KeyInputName,
	LeftAlt: KeyInputName,
	RightCommand: KeyInputName,
	LeftCommand: KeyInputName,
	AltGr: KeyInputName,
	Help: KeyInputName,
	Print: KeyInputName,
	SysReq: KeyInputName,
	Break: KeyInputName,
	Menu: KeyInputName
}
declare class KeyInputName extends InputName end
export type KeyboardChipEvent = {ButtonDown: boolean, ButtonUp: boolean, InputName: KeyInputName, Type: "KeyboardChipEvent"}

--MagneticConnector
declare class MagneticConnector extends Module
	ButtonState: boolean
	IsConnected: boolean
	AttachedConnector: MagneticConnector
end
export type MagneticConnectorEvent = {IsConnected: boolean, Type: "MagneticConnectorEvent"}

--PowerButton
declare class PowerButton extends Module
	ButtonState: false
end

--RealityChip
declare class RealityChip extends Module
	Cpu: {
		TotalUsage: number,
		CoresUsage: {number}
	}
	Ram: {
		Available: number,
		Used: number
	}
	Network: {
		TotalSent: number,
		TotalReceived: number
	}
	LoadedAssets: {Asset}

	GetDateTime: (self: RealityChip) -> {
		year: any,
		month: any,
		day: any,
		yday: any,
		wday: any,
		hour: any,
		min: any,
		sec: any,
		isdst: any
	}
	GetDateTimeUTC: (self: RealityChip) -> {
		year: any,
		month: any,
		day: any,
		yday: any,
		wday: any,
		hour: any,
		min: any,
		sec: any,
		isdst: any
	}
	LoadAudioSample: (self: RealityChip, filename: string) -> AudioSample
	LoadSpriteSheet: (self: RealityChip, filename: string, spritesWidth: number, spritesHeight: number) -> SpriteSheet
	UnloadAsset: (self: RealityChip, filename: string) -> ()
	ListDirectory: (self: RealityChip, directory: string) -> {string}
	GetFileMetadata: (self: RealityChip, filename: string) -> {[any]: any}
end

--ROM
declare class ROM extends Module
	User: {
		Assets: {[string]: Asset},
		SpriteSheets: {[string]: SpriteSheet},
		Codes: {[string]: Code},
		AudioSamples:{[string]: AudioSample}
	}
	System: {
		Assets: {[string]: Asset},
		SpriteSheets: {["StandardFont"]: SpriteSheet},
		Codes: {},
		AudioSamples: {}
	}
end

--SecurityChip
declare class SecurityChip extends Module
end

--VideoChip
declare class VideoChip extends Module
	Mode: VideoChipMode
	Width: number
	Height: number
	RenderBuffers: {RenderBuffer}
	TouchState: boolean
	TouchDown: boolean
	TouchUp: boolean
	TouchPosition: vec2

	RenderOnScreen: (self: VideoChip) -> ()
	RenderOnBuffer: (self: VideoChip, index: number) -> ()
	SetRenderBufferSize: (self: VideoChip, index: number, width: number, height: number) -> ()
	Clear: (self: VideoChip, color: color) -> ()
	SetPixel: (self: VideoChip, position: vec2, color: color) -> ()
	DrawPointGrid: (self: VideoChip, gridOffset: vec2, dotsDistance: number, color: color) -> ()
	DrawLine: (self: VideoChip, start: vec2, _end: vec2, color: color) -> ()
	DrawCircle: (self: VideoChip, position: vec2, radius: number, color: color) -> ()
	FillCircle: (self: VideoChip, position: vec2, radius: number, color: color) -> ()
	DrawRect: (self: VideoChip, position1: vec2, position2: vec2, color: color) -> ()
	FillRect: (self: VideoChip, position1: vec2, position2: vec2, color: color) -> ()
	DrawTriangle: (self: VideoChip, position1: vec2, position2: vec2, position3: vec2, color: color) -> ()
	FillTriangle: (self: VideoChip, position1: vec2, position2: vec2, position3: vec2, color: color) -> ()
	DrawSprite: (self: VideoChip, position: vec2, spriteSheet: SpriteSheet, spriteX: number, spriteY: number, tintColor: color, backgroundColor: color) -> ()
	DrawCustomSprite: (self: VideoChip, position: vec2, spriteSheet: SpriteSheet, spriteOffset: vec2, spriteSize: vec2, tintColor: color, backgroundColor: color) -> ()
	DrawText: (self: VideoChip, position: vec2, fontSprite: SpriteSheet, text: string, textColor: color, backgroundColor: color) -> ()
	RasterSprite: (self: VideoChip, position1: vec2, position2: vec2, position3: vec2, position4: vec2, spriteSheet: SpriteSheet, spriteX: number, spriteY: number, tintColor: color, backgroundColor: color) -> ()
	RasterCustomSprite: (self: VideoChip, position1: vec2, position2: vec2, position3: vec2, position4: vec2, spriteSheet: SpriteSheet, spriteOffset: vec2, spriteSize: vec2, tintColor: color, backgroundColor: color) -> ()
	DrawRenderBuffer: (self: VideoChip, position: vec2, renderBuffer: RenderBuffer, width: number, height: number) -> ()
	RasterRenderBuffer: (self: VideoChip, position1: vec2, position2: vec2, position3: vec2, position4: vec2, renderBuffer: RenderBuffer) -> ()
	SetPixelData: (self: VideoChip, pixelData: PixelData) -> ()
	BlitPixelData: (self: VideoChip, position: vec2, pixelData: PixelData) -> () 
end
export type VideoChipTouchEvent = {TouchDown: boolean, TouchUp: boolean, Value: vec2, Type: "VideoChipTouchEvent"}
declare class VideoChipMode end
declare VideoChipMode: {
	SingleBuffer: VideoChipMode,
	DoubleBuffer: VideoChipMode
}

--Wifi
declare class Wifi extends Module
	AccessDenied: boolean
	WebGet: (self: Wifi, url: string) -> number
	WebPutData: (self: Wifi, url: string, data: string) -> number
	WebPostData: (self: Wifi, url: string, data: string) -> number
	WebPostForm : (self: Wifi, url: string, form: {[string]: any}) -> number
	WebCustomRequest: (self: Wifi, url: string, method: string, customHeaderFields: {[string]: string}, contentType: string, contentData: string) -> number
	WebAbort: (self: Wifi, handle: number) -> boolean
	GetWebUploadProgress: (self: Wifi, handle: number) -> number
	GetWebDownloadProgress: (self: Wifi, handle: number) -> number
	ClearCookieCache: (self: Wifi) -> ()
	ClearUrlCookieCache: (self: Wifi, url: string) -> ()
end
export type WifiWebResponseEvent = {
	RequestHandle: number,
	ResponseCode: number,
	IsError: boolean,
	ErrorType: string,
	ErrorMessage: string,
	ContentType: string,
	Text: string,
	Data: string,
	Type: "WifiWebResponseEvent"
}

--Serial
declare class Serial extends Module
	ReceiveMode: SerialReceiveMode
	Port: number
	IsActive: boolean
	BaudRate: number
	DataBits: number
	Parity: SerialParity
	StopBits: SerialStopBits

	WriteInt8: (self: Serial, value: number) -> ()
	WriteUInt8: (self: Serial, value: number) -> ()
	WriteInt16: (self: Serial, value: number) -> ()
	WriteUInt16: (self: Serial, value: number) -> ()
	WriteInt32: (self: Serial, value: number) -> ()
	WriteUInt32: (self: Serial, value: number) -> ()
	WriteFloat32: (self: Serial, value: number) -> ()
	WriteFloat64: (self: Serial, value: number) -> ()
	Write: (self: Serial, data: string) -> ()
	Print: (self: Serial, text: string) -> ()
	Println: (self: Serial, text: string) -> ()
	GetAvailablePorts: (self: Serial) -> {number}
end
export type SerialIsActiveEvent = {IsActive: boolean, Type: "SerialIsActiveEvent"}
export type SerialReceiveEvent = {Lines: {string}, Data: string, Type: "SerialReceiveEvent"}
export type SerialEvent = SerialIsActiveEvent | SerialReceiveEvent
declare class SerialReceiveMode end
declare SerialReceiveMode: {
	BinaryData: SerialReceiveMode,
	Lines: SerialReceiveMode
}
declare class SerialParity end
declare SerialParity: {
	None: SerialParity,
	Odd: SerialParity,
	Even: SerialParity,
	Mark: SerialParity,
	Space: SerialParity
}
declare class SerialStopBits end
declare SerialStopBits: {
	One: SerialStopBits,
	OnePointFive: SerialStopBits,
	Two: SerialStopBits
}

----------------------------------------