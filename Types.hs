{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types where
import Control.Monad (mapM_)
import Control.Monad.State (StateT(..), MonadState(..), MonadIO(..))
							
data Room = SouthRoom | NorthRoom | Corridor | NoRoom
	deriving (Show, Eq)	-- Show ��������� ���������� ��� "SouthRoom" ��� "NorthRoom" ����������� ����������.
						-- Eq ��������� ���������� ��� ��������.
type Rooms = [Room]
type LongDescribedRooms = Rooms

data Direction = North | South | West | East | NoDirection
	deriving (Show, Eq, Read)
	
data ItemName =
			Phone
			| Table
			| Drawer
			| Umbrella
	deriving (Show, Eq, Read)
	
type Item = (ItemName, Integer)

data Object = Object {
	oItem :: Item,
	oName :: String,
	oDescription :: String,
	oPickupFailMsg :: String
} deriving (Eq)

type Objects = [Object]
type InventoryObjects = Objects
type Directions = [Direction]

data Path = Path {
    pathDir :: Direction,
    pathRoom :: Room
} deriving (Eq, Show)

type Paths = [Path]

data Location = Location {
	locRoom :: Room,
	locPaths :: Paths,
	locShortDesc :: String,
	locLongDesc :: String,
	locObjects :: Objects
} deriving (Eq)

type Locations = [Location]
	
data GameState = GameState {
	gsLocations :: Locations,
	gsCurrentRoom :: Room,
	gsRoomLongDescribed :: LongDescribedRooms, -- ���� ������� �������� ��� ����������, �� ������ ��� ��� �� ����� ����������. ������ �� ������� Look. � ������ gsRoomLongDescribed ���������� ��� ��������� �������.
	gsInvObjects :: InventoryObjects
}

newtype GS a = GS {
	runGameState :: StateT GameState IO a
} deriving (Monad, MonadIO, MonadState GameState)

data Command =
			Walk Direction
			| Look
			| Investigate ItemName
			| Inventory
			| Pickup ItemName		-- pickups if itemName parsed
			| Take String			-- tries pickup object by string
			| Quit
			| Help
	deriving (Eq, Show, Read)

type ParseResult = (Maybe Command, String)
	
type InputString = String
type OutputMessage = String

data GameAction =
				PrintMessage OutputMessage
				| QuitGame OutputMessage
				| ReadUserInput
				| ReadMessagedUserInput OutputMessage
				| SaveState GameState OutputMessage