local StatCache = require(game.ReplicatedStorage.ClientStatCache) 
writefile("BeeStatsExport.json", StatCache:Encode())
