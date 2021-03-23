FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env 

WORKDIR /app 

#copy cs project and restore it as distinct layer 

COPY *.csproj ./ 

RUN dotnet restore 

 

#copy everythign else and build 

COPY . ./ 

RUN dotnet publish -c Release -o out 

 

#Build Runtime Image 

FROM mcr.microsoft.com/dotnet/aspnet:5.0 

WORKDIR /app 

COPY --from=build-env /app/out . 

ENTRYPOINT ["dotnet","apnetcoreapp.dll"] 
