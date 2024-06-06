mkdir -p "${PREFIX}/Menu"
sed "s/__PKG_VERSION__/${PKG_VERSION}/" "${RECIPE_DIR}/menu.json" > "${PREFIX}/Menu/${PKG_NAME}_menu.json"
if [[ $(uname) == Darwin ]]; then
    ROOT_PREFIX=$(${CONDA_PYTHON_EXE} -c "from conda.base.context import context; print(context.root_prefix)")
    sed -e "s/__PREFIX__/${PREFIX}/" -e "s/__ROOT_PREFIX__/${ROOT_PREFIX}/" ${RECIPE_DIR}/anaconda_prompt_osx > ${PREFIX}/anaconda_prompt
    chmod 554 ${PREFIX}/anaconda_prompt
    ICON_EXT="icns"
else
    ICON_EXT="png"
fi
cp "${RECIPE_DIR}/anaconda_prompt.${ICON_EXT}" "${PREFIX}/Menu/"
