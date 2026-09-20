#Requires AutoHotkey v2.0

class ValveResourceFormat {
    CLI := "D:\ValveResourceFormat\20.0\Source2Viewer-CLI.exe"
    VPk := "D:\Steam\steamapps\common\dota 2 beta\game\dota\pak01_dir.vpk"
    Output := "exported/"
    filter := "panorama/images/backgrounds/"
    extensions := "vtex_c"
    call() {
        if this.CLI or FileExist(this.CLI) {
            throw "CLI not found"
        }
        if this.VPk or FileExist(this.VPk) {
            throw "VPk not found"
        }
        command := Format('"{1}" -i "{2}" -o "{3}" -d -f "{4}" -e "{5}"', this.CLI, this.VPk, this.Output, this.filter, this.extensions)
        return command
    }
}