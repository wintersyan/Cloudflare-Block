#!/usr/bin/env bash

# Gestion de l'état

is_attack_mode_enabled() {
    [[ -f "$STATE_FILE" ]]
}

enable_attack_mode() {
    cloudflare_set_mode "under_attack"
    touch "$STATE_FILE"
}

disable_attack_mode() {
    cloudflare_set_mode "medium"
    rm -f "$STATE_FILE"
}

# Principal

main() {
    require_binary curl
    require_binary awk
    require_binary logger

    local current_load
    current_load=$(get_load_average)

    log "Current load average: ${current_load}"

    if is_attack_mode_enabled; then

        if float_lower_or_equal "$current_load" "$LOAD_THRESHOLD_DISABLE"; then
            log "Load back to normal, disabling Under Attack mode"
            disable_attack_mode
        else
            log "Under Attack mode already enabled"
        fi

    else

        if float_greater_or_equal "$current_load" "$LOAD_THRESHOLD_ENABLE"; then
            log "High load detected, enabling Under Attack mode"
            enable_attack_mode
        else
            log "Load is normal"
        fi

    fi
}

main "$@"
