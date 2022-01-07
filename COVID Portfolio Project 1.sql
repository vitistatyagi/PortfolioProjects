select *
from `sqlproject1-covid.Tables.CovidDeaths`
where continent is not null
order by 3,4

select *
from `sqlproject1-covid.Tables.CovidVaccinations`
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from `sqlproject1-covid.Tables.CovidDeaths`
order by 1,2

--Total cases vs Total Deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from `sqlproject1-covid.Tables.CovidDeaths`
where location ='India'
order by 1,2

--Total Cases vs Population
select location, date, total_cases, population, (total_cases/population)*100 as InfectedPercentage
from `sqlproject1-covid.Tables.CovidDeaths`
where location ='India'
order by 1,2

--Country with highest infection rate compared to population
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as InfectedPercentage
from `sqlproject1-covid.Tables.CovidDeaths`
group by 1,2
order by 4 desc

--Countries with highest death count per pop.
select location, max(total_deaths) as TotalDeathsCount 
from `sqlproject1-covid.Tables.CovidDeaths`
where continent is not null
group by 1
order by 2 desc

--Continent breakdown
select continent, max(total_deaths) as TotalDeathsCount 
from `sqlproject1-covid.Tables.CovidDeaths`
where continent is not null 
group by 1
order by 2 desc

--global numbers
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths,(sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from `sqlproject1-covid.Tables.CovidDeaths`
where continent is not null 
--group by 1
order by 1,2


--Total Population vs Vaccinations
select death.continent, death.location, death.date, death.population, 
 vac.new_vaccinations, 
 sum(vac.new_vaccinations) over (partition by death.location order by death.location, death.date) as CumulativeVaccination
from `sqlproject1-covid.Tables.CovidDeaths` death
join `sqlproject1-covid.Tables.CovidVaccinations` vac
 on death.location = vac.location and death.date = vac.date
where death.continent is not null 
--order by 2,3 

--Created a temp table (PopvsVac)
select *, (CumulativeVaccination/population)*100 as VaccinatedPercentage 
from `sqlproject1-covid.Tables.PopvsVac`

--Creating view to store data for later visualizations
CREATE VIEW Tables.PercentPopulationVaccinated as 
select death.continent, death.location, death.date, death.population, 
 vac.new_vaccinations, 
 sum(vac.new_vaccinations) over (partition by death.location order by death.location, death.date) as CumulativeVaccination
from `sqlproject1-covid.Tables.CovidDeaths` death
join `sqlproject1-covid.Tables.CovidVaccinations` vac
 on death.location = vac.location and death.date = vac.date
where death.continent is not null
--order by 2,3

select * 
from `sqlproject1-covid.Tables.PercentPopulationVaccinated`




