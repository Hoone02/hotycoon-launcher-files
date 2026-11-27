// Nebula 가 만든 distribution.json 에 extra-modules.json 의 모듈을 붙인다(update-mods.ps1 이 부른다).
const fs = require('fs')
const path = require('path')
const distFile = path.join(__dirname, 'distribution.json')
const extra = JSON.parse(fs.readFileSync(path.join(__dirname, 'extra-modules.json'), 'utf8'))
const dist = JSON.parse(fs.readFileSync(distFile, 'utf8'))
for (const [serverId, mods] of Object.entries(extra)) {
    if (serverId.startsWith('_')) continue
    const server = dist.servers.find(s => s.id === serverId)
    if (server == null) throw new Error(`distribution.json 에 서버 ${serverId} 가 없다`)
    for (const m of mods) {
        server.modules = server.modules.filter(x => x.id !== m.id)
        server.modules.push(m)
    }
}
fs.writeFileSync(distFile, JSON.stringify(dist, null, 2))
console.log('추가 모듈을 붙였어요.')
