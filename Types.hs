module Types where

data Location = Room | NorthRoom | Corridor
	deriving (Show, Eq)	-- Show ��������� ���������� ��� "Room" ��� "NorthRoom" ����������� ����������.
						-- Eq ��������� ���������� ��� ��������.
	
data Direction = North | South | West | East | NoDirection
	deriving (Show, Eq)


type ShortDescription = String	-- ������� �������� ��� ������.
type LongDescription = String

data Path = Path {
    dir :: Direction,
    toLoc :: Location
} deriving (Eq, Show)

type Paths = [Path]
type Directions = [Direction]