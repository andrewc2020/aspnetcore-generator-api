# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env

WORKDIR /generator

#restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

COPY nunitTests/nunitTests.csproj ./nunitTests/
RUN dotnet restore nunitTests/nunitTests.csproj


#copy src
COPY . .

#test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj
RUN dotnet test nunitTests/nunitTests.csproj

#publish

RUN dotnet publish api/api.csproj -o /publish

#Runtime stage
FROM microsoft/aspnetcore:2.0
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]


