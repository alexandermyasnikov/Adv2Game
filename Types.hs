module Types where

data Room = SouthRoom | NorthRoom | Corridor
	deriving (Show, Eq)	-- Show ��������� ���������� ��� "Room" ��� "NorthRoom" ����������� ����������.
						-- Eq ��������� ���������� ��� ��������.
	
data Direction = North | South | West | East | NoDirection
	deriving (Show, Eq)

type Directions = [Direction]

data Path = Path {
    dir :: Direction,
    toLoc :: Room
} deriving (Eq, Show)

type Paths = [Path]

data Location = Location {
	paths :: Paths,
	shortDesc :: String,
	longDesc :: String
} deriving (Eq, Show)

