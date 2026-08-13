do_install:append:osm-mtk520() {
    INI_FILE=${D}${sysconfdir}/xdg/weston/weston.ini

    if ! grep -q "^\[core\]" $INI_FILE; then
        echo "" >> $INI_FILE
        echo "[core]" >> $INI_FILE
    fi

    if ! grep -q "require-outputs=none" $INI_FILE; then
        sed -i '/^\[core\]/a require-outputs=none' $INI_FILE
    fi

    if ! grep -q "require-input=false" $INI_FILE; then
        sed -i '/^\[core\]/a require-input=false' $INI_FILE
    fi
}

do_install:append:osm-mtk510() {
    INI_FILE=${D}${sysconfdir}/xdg/weston/weston.ini

    if ! grep -q "^\[core\]" $INI_FILE; then
        echo "" >> $INI_FILE
        echo "[core]" >> $INI_FILE
    fi

    if ! grep -q "require-outputs=none" $INI_FILE; then
        sed -i '/^\[core\]/a require-outputs=none' $INI_FILE
    fi

    if ! grep -q "require-input=false" $INI_FILE; then
        sed -i '/^\[core\]/a require-input=false' $INI_FILE
    fi
}

