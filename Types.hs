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

data Command =
			Walk Direction
			| Look
			| Investigate ItemName
			| Inventory
			| Pickup ItemName
			| Quit
			| Help
	deriving (Eq, Show, Read)
{-
type QualifiedInput = (Command, String) -- maybe command, qualifiedString

data GameAction =
				PrintMessage
				| QuitGame
				| ReadUserInput
				| SaveState
type GameActionResult = (GameAction, String, Maybe GameState, Maybe QualifiedInput) -- game action, message for user, maybe gamestate, maybe qualinput
type PickupResult = (String, Maybe GameState, Maybe QualifiedInput)
-}
data GameState = GameState {
	gsLocations :: Locations,
	gsCurrentRoom :: Room,
	gsRoomLongDescribed :: LongDescribedRooms, -- ���� ������� �������� ��� ����������, �� ������ ��� ��� �� ����� ����������. ������ �� ������� Look. � ������ gsRoomLongDescribed ���������� ��� ��������� �������.
	gsInvObjects :: InventoryObjects
}

newtype GS a = GS {
	runGameState :: StateT GameState IO a
} deriving (Monad, MonadIO, MonadState GameState)