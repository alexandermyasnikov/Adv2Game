{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types where
import Control.Monad (mapM_)
import Control.Monad.State (StateT(..), MonadState(..), MonadIO(..))
							
data Room = SouthRoom | NorthRoom | Corridor | NoRoom
	deriving (Show, Eq)	-- Show ��������� ���������� ��� "SouthRoom" ��� "NorthRoom" ����������� ����������.
						-- Eq ��������� ���������� ��� ��������.
type Rooms = [Room]


data Direction = North | South | West | East | NoDirection
	deriving (Show, Eq, Read)
	
data Object =
			Phone
			| Table
			| Drawer	-- ��������� ���� �����
	deriving (Show, Eq, Read)
	
type Objects = [Object]

data Command =
			Walk Direction
			| Look
			| Investigate Object
			| Go Direction
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
	gsWorldMap :: Locations,
	gsCurrentRoom :: Room,
	gsRoomLongDescribed :: Rooms -- ���� ������� �������� ��� ����������, �� ������ ��� ��� �� ����� ����������. ������ �� ������� Look.
}
	deriving (Show)

newtype GS a = GS { runGameState :: StateT GameState IO a }
    deriving (Monad, MonadIO, MonadState GameState)