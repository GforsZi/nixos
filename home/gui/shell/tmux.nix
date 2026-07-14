{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_current_number_color "#{@thm_blue}"
          set -g @catppuccin_window_text ""
          set -g @catppuccin_window_number "#[bold]Tab ###I "
          set -g @catppuccin_window_current_text ""
          set -g @catppuccin_window_current_number "#[bold]Tab ###I "
          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},reverse]#[none]"
          set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg}] #[none]"
          set -g @catppuccin_window_middle_separator "#[bg=#{@catppuccin_window_text_color},fg=#{@catppuccin_window_number_color}]"
          set -g @catppuccin_window_current_middle_separator "#[bg=#{@catppuccin_window_current_text_color},fg=#{@catppuccin_window_current_number_color}]"
          set -g @catppuccin_status_left_separator "#[reverse]#[none]"
          set -g @catppuccin_status_middle_separator ""
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_connect_separator "yes"
        '';
      }
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -as terminal-features ",xterm-kitty:RGB"
      unbind r
      bind r source-file ~/.tmux.conf
      bind c new-window -c "$HOME"

      set -g status-position top
      setw -g pane-base-index 1
      set -g renumber-windows on

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -g window-status-separator ""
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left "#{E:@catppuccin_status_application}"
      set -g status-left "#[fg=#{@thm_fg} bold]TMUX: #S | "
      set -ga status-left "#{?client_prefix,#[fg=#{@thm_red} bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY ,#[fg=#{@thm_blue} bold]NORMAL }}"
      set -g status-right "#[fg=#{@thm_blue} bold] #{pane_current_command} #[fg=#{@thm_fg} bold]|#[fg=#{@thm_blue} bold] %A #[fg=#{@thm_fg} bold]| %d-%m-%Y "
    '';
  };
}
