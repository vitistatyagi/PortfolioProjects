select * 
from NashvilleHousing

select SaleDate, CONVERT(Date, SaleDate)
from NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

Alter table NashvilleHousing
Add SaleDateConverted Date

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


--Populate Property Address 
select PropertyAddress 
from NashvilleHousing
where PropertyAddress is null

--join the table to itself
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
 on a.[ParcelID] = b.[ParcelID]
 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
 on a.[ParcelID] = b.[ParcelID]
 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--Split Add into diff. cols. (Address, City)
select PropertyAddress
from NashvilleHousing

select 
 SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
 SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) as City
from NashvilleHousing

Alter table NashvilleHousing
Add PropertySplitAddress Nvarchar(255)

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) 

Alter table NashvilleHousing
Add PropertySplitCity Nvarchar(255)

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) 


--Split OwnerAdd into diff. cols. (Address, City, State)
select OwnerAddress
from NashvilleHousing

--parsename only take '.' and work backwards
select 
 PARSENAME(REPLACE(OwnerAddress, ',','.'),1) as state,
 PARSENAME(REPLACE(OwnerAddress, ',','.'),2) as city,
 PARSENAME(REPLACE(OwnerAddress, ',','.'),3) as address
from NashvilleHousing

Alter table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255)

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3) 

Alter table NashvilleHousing
Add OwnerSplitCity Nvarchar(255)

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'),2) 

Alter table NashvilleHousing
Add OwnerSplitState Nvarchar(255)

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'),1)


--SoldAsVacant col.
select distinct SoldAsVacant, count(SoldAsVacant) 
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
 case when SoldAsVacant='Y' then 'Yes'
      when SoldAsVacant='N' then 'No'
	  else SoldAsVacant
	  end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant='Y' then 'Yes'
                        when SoldAsVacant='N' then 'No'
	                    else SoldAsVacant
	                    end


--Remove duplicates

With RowNumCTE AS(
select *, 
 ROW_NUMBER() over(
 partition by ParcelID,
              PropertyAddress,
			  SalePrice,
			  SaleDate,
			  LegalReference
			  ORDER BY UniqueID) row_num
from NashvilleHousing
)
select * --delete
from RowNumCTE
where row_num>1


-- Drop unused cols.
alter table NashvilleHousing
drop column OwnerAddress, PropertyAddress, TaxDistrict, SaleDate 


