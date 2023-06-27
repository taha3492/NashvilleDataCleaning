Select * 
from Nashville


-- Standardize Date Format


Select SaleDate 
From Nashville 

Select SaleDateconverted, Convert(Date,SaleDate) 
from Nashville 


Update Nashville
SET SaleDate = Convert(Date,SaleDate) 


ALTER TABLE Nashville 
ADD SaleDateConverted Date; 

Update Nashville
SET SaleDateConverted = Convert(Date,SaleDate) 


-- Populate Property Address Data


Select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, ISNULL(a.propertyaddress, b.propertyaddress)
From Nashville a
Join NashVille b 
on a.parcelid = b.parcelid 
and a.uniqueid <> b.uniqueID
where a.propertyaddress is null 


Update a
Set PropertyAddress = isnull(a.propertyaddress,b.propertyaddress)
From Nashville a
Join NashVille b 
on a.parcelid = b.parcelid 
and a.uniqueid <> b.uniqueID
where a.propertyaddress is null 

Select * 
from Nashville 
where propertyaddress is null 


--- Breaking Out Address into Individual Columns 

Select Propertyaddress 
From Nashville 

Select Substring(PropertyAddress, 1, charindex(',',PropertyAddress)-1) as Address,
Substring(PropertyAddress, charindex(',',PropertyAddress)+1, Len(propertyaddress)) as Address
From Nashville

Alter Table Nashville 
Add PropertySplitAddress Nvarchar(255); 

Update Nashville
Set PropertySplitAddress = Substring(PropertyAddress, 1, charindex(',',PropertyAddress)-1)

Alter Table Nashville 
Add PropertySplitCity  Nvarchar(255);

Update Nashville 
Set PropertySplitCity = Substring(PropertyAddress, charindex(',',PropertyAddress)+1, Len(propertyaddress))

Select * 
From Nashville 





Select OwnerAddress 
From Nashville 

Select ParseName(Replace(OwnerAddress,',','.'),3),
ParseName(Replace(OwnerAddress,',','.'),2),
ParseName(Replace(OwnerAddress,',','.'),1)

From Nashville 


Alter Table Nashville 
Add OnwerSplitAddress Nvarchar(255); 

Update Nashville
Set OnwerSplitAddress = ParseName(Replace(OwnerAddress,',','.'),3)

Alter Table Nashville 
Add OwnerSplitCity Nvarchar(255);

Update Nashville 
Set OwnerSplitCity = ParseName(Replace(OwnerAddress,',','.'),2)

Alter Table Nashville 
Add OwnerSplitState Nvarchar(255);

Update Nashville 
Set OwnerSplitState = ParseName(Replace(OwnerAddress,',','.'),1)


Select * 
From Nashville 



--- Change Y and N to Yes and No in "Solid as Vacant" Field

Select Distinct(SoldAsVacant), Count(SoldasVacant)
From Nashville 
group by Soldasvacant
order by 2



Select soldasvacant,
Case When SoldAsVacant = 'Y' Then 'Yes' 
     When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant 
	 END
From Nashville

where soldasVacant = 'N' or Soldasvacant = 'Y'

update Nashville 
Set SoldAsVacant = 
Case When SoldAsVacant = 'Y' Then 'Yes' 
     When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant 
	 END



--- Remove Duplicates 

With RowNumCTE AS (
Select * , 
  ROW_NUMBER() over (
  Partition BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   Order By 
			     UniqueID
				 ) row_num

From Nashville ) 

Delete 
From RowNUMCTE 
where row_num > 1

With RowNumCTE AS (
Select * , 
  ROW_NUMBER() over (
  Partition BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   Order By 
			     UniqueID
				 ) row_num

From Nashville ) 

Select *  
From RowNUMCTE 
where row_num > 1


Select * 
From Nashville 



-- Delete Unused Columns 

Select * 
From Nashville 

Alter Table Nashville 
Drop Column SaleDate 


Select * 
From Nashville 
where OwnerName is Null 
