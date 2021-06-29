FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
EXPOSE 80

#ENV ASPNETCORE_URLS=http://localhost:5000

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
#USER appuser

FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build
WORKDIR /src
COPY ["Catalogos.csproj", "./"]
RUN dotnet restore "./Catalogos.csproj"
COPY . .
#WORKDIR "/src/."
#RUN dotnet build "Catalogos.csproj" -c Release -o /app/build

#FROM build AS publish
RUN dotnet publish "Catalogos.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Catalogos.dll"]
