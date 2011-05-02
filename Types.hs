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
	
data Object =
			Phone
			| Table
			| Drawer	-- ��������� ���� �����
			| Umbrella
	deriving (Show, Eq, Read)
	
type Objects = [Object]
type Inventory = Objects

data Command =
			Walk Direction
			| Look
			| Investigate Object
			| Inventory
			| Go Direction
			| Use Object
			| Pickup Object
			| Quit
			| Help
	deriving (Eq, Show, Read)

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
} deriving (Eq, Show)

type Locations = [Location]

-- ����� ������� ��������� ����. ������ �� ������� Advgame.
data Result = Won | Lost | ContinueGame | QuitGame
    deriving (Eq)

data GameState = GameState {
	gsLocations :: Locations,
	gsCurrentRoom :: Room,
	gsRoomLongDescribed :: LongDescribedRooms, -- ���� ������� �������� ��� ����������, �� ������ ��� ��� �� ����� ����������. ������ �� ������� Look. � ������ gsRoomLongDescribed ���������� ��� ��������� �������.
	gsInventory :: Inventory
}
	deriving (Show)

newtype GS a = GS { runGameState :: StateT GameState IO a }
    deriving (Monad, MonadIO, MonadState GameState)