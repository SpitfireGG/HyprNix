{ pkgs, ... }:
{
  fonts = {
    packages =

      with pkgs; [
        corefonts
        inconsolata
        source-code-pro
        dosis
        material-symbols
        rubik
        work-sans
        nerd-fonts._0xproto
        nerd-fonts.commit-mono
        nerd-fonts.roboto-mono
        victor-mono
        fantasque-sans-mono

        maple-mono.truetype
        # Maple Mono NF (Ligature unhinted)
        maple-mono.NF-unhinted
        # Maple Mono NF CN (Ligature unhinted)
        maple-mono.NF-CN-unhinted

      ];
    # ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues nerd-fonts);
  };

}
